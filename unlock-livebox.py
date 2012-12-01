#!/usr/bin/env python
# -*- coding: utf-8 -*-

import telnetlib, time

# Poner esto a 0 para deshabilitar las opciones del menú
# o a 1 para habilitarlas
HABILITAR = 1;

tn = telnetlib.Telnet ( "192.168.1.1" );
tn.read_until("login: ");
tn.write("LBV2techno\n");
tn.read_until("Password: ");
tn.write("1901b95ae4295d613abf9eabae0b9d40\n");
for i in `range(1,3)`:
    tn.write("\n");
    tn.write("rg_conf_set wbm/settings/pages/backuprestore %i\n" % HABILITAR);
    tn.read_until("Returned 0");
    tn.write("rg_conf_set wbm/settings/pages/vpn %i\n" % HABILITAR);
    tn.read_until("Returned 0");
    tn.write("rg_conf_set wbm/settings/pages/fax %i\n" % HABILITAR);
    tn.read_until("Returned 0");
    tn.write("rg_conf_set wbm/settings/pages/log %i\n" % HABILITAR);
    tn.read_until("Returned 0");
    tn.write("rg_conf_set wbm/settings/pages/licence %i\n" % HABILITAR);
    tn.read_until("Returned 0");
    tn.write("rg_conf_set wbm/settings/pages/community %i\n" % HABILITAR);
    tn.read_until("Returned 0");
    tn.write("rg_conf_set wbm/settings/pages/visio %i\n" % HABILITAR);
    tn.read_until("Returned 0");
    tn.write("rg_conf_set wbm/settings/pages/livezoom %i\n" % HABILITAR);
    tn.read_until("Returned 0");
    tn.write("rg_conf_set wbm/settings/pages/hsiab %i\n" % HABILITAR);
    tn.read_until("Returned 0");
    tn.write("rg_conf_set wbm/settings/network/dhcp %i\n" % HABILITAR);
    tn.read_until("Returned 0");
    tn.write("rg_conf_set wbm/settings/network/ftlock %i\n" % HABILITAR);
    tn.read_until("Returned 0");
    tn.write("rg_conf_set wbm/settings/network/ftlock %i\n" % HABILITAR);
    tn.read_until("Returned 0");
    tn.write("rg_conf_set wbm/settings/network/tvrouted %i\n" % HABILITAR);
    tn.read_until("Returned 0");
    tn.write("rg_conf_set wbm/settings/services/professionnal %i\n" % HABILITAR);
    tn.read_until("Returned 0");
    tn.write("rg_conf_set wbm/settings/services/rtcphone %i\n" % HABILITAR);
    tn.read_until("Returned 0");
    tn.write("rg_conf_set wbm/settings/services/universal_phone %i\n" % HABILITAR);
    tn.read_until("Returned 0");
    tn.write("rg_conf_set wbm/settings/services/wifipushbutton %i\n" % HABILITAR);
    tn.read_until("Returned 0");
    tn.write("rg_conf_set wbm/settings/services/msgwaiting %i\n" % HABILITAR);
    tn.read_until("Returned 0");
    tn.write("rg_conf_set wbm/settings/test/sipdev %i\n" % HABILITAR);
    tn.read_until("Returned 0");
    tn.write("rg_conf_set wbm/settings/test/fmdev %i\n" % HABILITAR);
    tn.read_until("Returned 0");
    tn.write("rg_conf_set wbm/settings/network/h323 %i\n" % HABILITAR);
    tn.read_until("Returned 0");
    tn.write("rg_conf_set wbm/settings/services/wpspushbutton %i\n" % HABILITAR);
    tn.read_until("Returned 0");
    tn.write("save\n");
    time.sleep(2);
    tn.write("reboot\n");
