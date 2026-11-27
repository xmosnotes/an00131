// Copyright 2015-2026 XMOS LIMITED.
// This Software is subject to the terms of the XMOS Public Licence: Version 1.

#include <ethernet.h>
#include <print.h>
#include <string.h>
#include <stdio.h>
#include "femtoTCP.h"
#include "gpio.h"

/* The demo TCP stack sends each response as a single TCP segment, so the whole
 * response must fit in one Ethernet frame:
 * 1514 - 14 (Ethernet header) - 20 (IP header) - 20 (TCP header) = 1460 bytes */
#define HTTP_MAX_RESPONSE   1460

/* Number of bytes of the request line that are examined, e.g. "GET /?led=15 " */
#define REQ_LEN             32

static char body[HTTP_MAX_RESPONSE];
static char response[HTTP_MAX_RESPONSE + 1];
static unsigned bodyLen;

/* Append formatted text to the page body, truncating if it does not fit */
#define APPEND(...) \
    do { \
        int n = snprintf(body + bodyLen, sizeof(body) - bodyLen, __VA_ARGS__); \
        if (n > 0) bodyLen += n; \
        if (bodyLen >= sizeof(body)) bodyLen = sizeof(body) - 1; \
    } while (0)

static void buildPage(void)
{
    unsigned leds = ledsGet();
    unsigned buttons = buttonsGet();

    bodyLen = 0;

    APPEND("<!DOCTYPE html>\n<html><head><title>xcore USB CDC-ECM demo</title>\n"
           "<style>table,td{border:1px solid black;border-collapse:collapse}td{padding:5px 15px}</style>\n"
           "</head><body>\n"
           "<h2>XMOS USB CDC-ECM Class demo</h2>\n"
           "<p>This page is served by an xcore that has enumerated as a USB CDC-ECM "
           "(Ethernet over USB) device on this host.</p>\n");

    /* Board controls. Each link carries the complete LED mask to apply, so
     * refreshing the page does not change the LEDs again */
    APPEND("<h3>Board controls</h3>\n<table>\n");
    for (int i = 0; i < NUM_LEDS; i++) {
        unsigned ledOn = (leds >> i) & 1;
        APPEND("<tr><td>LED %d</td><td>%s</td><td><a href=\"/?led=%u\">Turn %s</a></td></tr>\n",
               i, ledOn ? "On" : "Off", leds ^ (1 << i), ledOn ? "off" : "on");
    }
    for (int i = 0; i < NUM_BUTTONS; i++) {
        APPEND("<tr><td>Button %d</td><td>%s</td><td></td></tr>\n",
               i, ((buttons >> i) & 1) ? "Pressed" : "Released");
    }
    APPEND("</table>\n<p><a href=\"/\">Refresh</a></p>\n");

    /* Network statistics */
    APPEND("<h3>Network packet statistics</h3>\n<table>\n");
    APPEND("<tr><td>Total packets received</td><td>%u</td></tr>\n", stats.total_rx_packets);
    APPEND("<tr><td>Total packets transmitted</td><td>%u</td></tr>\n", stats.total_tx_packets);
    APPEND("<tr><td>ARP packets received</td><td>%u</td></tr>\n", stats.arp_rx_packets);
    APPEND("<tr><td>TCP packets received</td><td>%u</td></tr>\n", stats.tcp_rx_packets);
    APPEND("<tr><td>UDP packets received</td><td>%u</td></tr>\n", stats.udp_rx_packets);
    APPEND("<tr><td>ICMP packets received</td><td>%u</td></tr>\n", stats.icmp_rx_packets);
    APPEND("<tr><td>Total bytes received</td><td>%u</td></tr>\n", stats.total_rx_bytes);
    APPEND("<tr><td>Total bytes transmitted</td><td>%u</td></tr>\n", stats.total_tx_bytes);
    APPEND("</table>\n</body></html>\n");
}

static void sendPage(unsigned int rsp_packet[], unsigned &rsp_len)
{
    buildPage();

    /* Build the HTTP header now that the body length is known */
    int n = snprintf(response, sizeof(response),
                     "HTTP/1.0 200 OK\r\nContent-Type: text/html\r\nContent-Length: %u\r\n\r\n%s",
                     bodyLen, body);
    if (n >= sizeof(response)) {
        printstrln("HTTP response truncated");
    }
    tcpString(response, rsp_packet, rsp_len);
}

void httpProcess(unsigned int packet[], int charOffset, int packetLength, unsigned int rsp_packet[], unsigned &rsp_len)
{
    char request[REQ_LEN];
    int len = (packetLength < REQ_LEN - 1) ? packetLength : REQ_LEN - 1;

    for (int i = 0; i < len; i++) {
        request[i] = (packet, unsigned char[])[charOffset + i];
    }
    request[len] = 0;

    if (strncmp(request, "GET /?led=", 10) == 0) {
        /* Set the LEDs from the decimal mask in the URL, then return the page */
        unsigned mask = 0;
        for (int i = 10; request[i] >= '0' && request[i] <= '9'; i++) {
            mask = (mask * 10) + (request[i] - '0');
        }
        ledsSet(mask);
        sendPage(rsp_packet, rsp_len);
    } else if ((strncmp(request, "GET / ", 6) == 0) || (strncmp(request, "GET /?", 6) == 0)) {
        sendPage(rsp_packet, rsp_len);
    } else {
        /* Anything else, e.g. /favicon.ico */
        tcpString("HTTP/1.0 404 NOT FOUND\r\n\r\n", rsp_packet, rsp_len);
    }
}
