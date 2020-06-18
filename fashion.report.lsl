/*
 * fashion report v1.5 ( https://github.com/colorsoundoblivion/fashion.report/ )
 * Copyright (C) 2020 Felix (colorsoundoblivion)
 *
 * Permission to use, copy, modify, and/or distribute this software for any
 * purpose with or without fee is hereby granted.
 *
 * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
 * SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION
 * OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
 * CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 */
//////////////////////////////////////////////<-- 110 width -->//////////////////////////////////////////////

key Owner;
list DetectedNames1;
list DetectedNames2;
integer Channel;
integer DetectedTotal;
integer Listener;
integer ListenerTimeElapsed;
integer UuidNotFound;

setupListener()
{
    ListenerTimeElapsed = 0;
    if (Listener == 0) {
        Listener = llListen(Channel, "", Owner, "");
        llSetTimerEvent(1);
    }
}

cleanupListener()
{
    llListenRemove(Listener);
    Listener = 0;
    ListenerTimeElapsed = 0;
    llSetTimerEvent(0);
}

string getPointName(string id)
{
    if (id == "1") return "Chest";
    else if (id == "2") return "Skull";
    else if (id == "3") return "Left Shoulder";
    else if (id == "4") return "Right Shoulder";
    else if (id == "5") return "Left Hand";
    else if (id == "6") return "Right Hand";
    else if (id == "7") return "Left Foot";
    else if (id == "8") return "Right Foot";
    else if (id == "9") return "Spine";
    else if (id == "10") return "Pelvis";
    else if (id == "11") return "Mouth";
    else if (id == "12") return "Chin";
    else if (id == "13") return "Left Ear";
    else if (id == "14") return "Right Ear";
    else if (id == "15") return "Left Eyeball";
    else if (id == "16") return "Right Eyeball";
    else if (id == "17") return "Nose";
    else if (id == "18") return "R Upper Arm";
    else if (id == "19") return "R Forearm";
    else if (id == "20") return "L Upper Arm";
    else if (id == "21") return "L Forearm";
    else if (id == "22") return "Right Hip";
    else if (id == "23") return "R Upper Leg";
    else if (id == "24") return "R Lower Leg";
    else if (id == "25") return "Left Hip";
    else if (id == "26") return "L Upper Leg";
    else if (id == "27") return "L Lower Leg";
    else if (id == "28") return "Stomach";
    else if (id == "29") return "Left Pec";
    else if (id == "30") return "Right Pec";
    else if (id == "39") return "Neck";
    else if (id == "40") return "Avatar Center";
    else if (id == "41") return "Left Ring Finger";
    else if (id == "42") return "Right Ring Finger";
    else if (id == "43") return "Tail Base";
    else if (id == "44") return "Tail Tip";
    else if (id == "45") return "Left Wing";
    else if (id == "46") return "Right Wing";
    else if (id == "47") return "Jaw";
    else if (id == "48") return "Alt Left Ear";
    else if (id == "49") return "Alt Right Ear";
    else if (id == "50") return "Alt Left Eye";
    else if (id == "51") return "Alt Right Eye";
    else if (id == "52") return "Tongue";
    else if (id == "53") return "Groin";
    else if (id == "54") return "Left Hind Foot";
    else if (id == "55") return "Right Hind Foot";
    else return "Unknown";
}

printReport(key uuid)
{
    llOwnerSay("***************************************");
    llOwnerSay("[ secondlife:///app/agent/" + (string) uuid + "/about ]");
    llOwnerSay(" ");

    integer object = 0;
    list uuids = llGetAttachedList(uuid);
    list names;
    list creators;
    list points;
    while (object < llGetListLength(uuids))
    {
        names = llGetObjectDetails(llList2Key(uuids, object), [OBJECT_NAME]);
        creators = llGetObjectDetails(llList2Key(uuids, object), [OBJECT_CREATOR]);
        points = llGetObjectDetails(llList2Key(uuids, object), [OBJECT_ATTACHED_POINT]);
        llOwnerSay(llList2String(names, 0)
            + " (worn on " + getPointName(llList2String(points, 0)) + ") "
            + "[ secondlife:///app/agent/" + llList2String(creators, 0) + "/about ]");
        object++;
    }

    cleanupListener();
}

otherMenu()
{
    string status = "\npaste in the UUID to report\n";
    if (UuidNotFound == TRUE) status += "\nthe user UUID was not found in the region, try again\n";
    else status += "\nthe user must be in the same region as you\n";

    UuidNotFound = FALSE;

    llTextBox(Owner, status, Channel);
}

page1Menu()
{
    setupListener();

    string status = "\nreport on who? (1/1)\n\n";
    if (DetectedTotal > 9) status = "\nreport on who? (1/2)\n\n";

    integer user = 0;
    integer list_pos = 0;
    while (user < llList2Integer(DetectedNames1, 0)) {
        status += llList2String(DetectedNames1, list_pos + 1) + "\n";
        user++;
        list_pos += 2;
    }

    list choices = ["other", "refresh"];
    if (DetectedTotal > 9) choices += "page 2";
    else choices += " ";
    if (DetectedTotal > 6) choices += "A07";
    else choices += " ";
    if (DetectedTotal > 7) choices += "A08";
    else choices += " ";
    if (DetectedTotal > 8) choices += "A09";
    else choices += " ";
    if (DetectedTotal > 3) choices += "A04";
    else choices += " ";
    if (DetectedTotal > 4) choices += "A05";
    else choices += " ";
    if (DetectedTotal > 5) choices += "A06";
    else choices += " ";
    if (DetectedTotal > 0) choices += "A01";
    else choices += " ";
    if (DetectedTotal > 1) choices += "A02";
    else choices += " ";
    if (DetectedTotal > 2) choices += "A03";
    else choices += " ";

    llDialog(Owner, status, choices, Channel);
}

page2Menu()
{
    ListenerTimeElapsed = 0;

    string status = "\nreport on who? (2/2)\n\n";

    integer user = 0;
    integer list_pos = 0;
    while (user < llList2Integer(DetectedNames2, 0)) {
        status += llList2String(DetectedNames2, list_pos + 1) + "\n";
        user++;
        list_pos += 2;
    }

    list choices = ["other", "refresh", "page 1"];
    if (DetectedTotal > 15) {
        choices += " ";
        choices += "A16";
        choices += " ";
    } else {
        choices += " ";
        choices += " ";
        choices += " ";
    }
    if (DetectedTotal > 12) choices += "A13";
    else choices += " ";
    if (DetectedTotal > 13) choices += "A14";
    else choices += " ";
    if (DetectedTotal > 14) choices += "A15";
    else choices += " ";
    if (DetectedTotal > 9) choices += "A10";
    else choices += " ";
    if (DetectedTotal > 10) choices += "A11";
    else choices += " ";
    if (DetectedTotal > 11) choices += "A12";
    else choices += " ";

    llDialog(Owner, status, choices, Channel);
}

default
{
    state_entry()
    {
        Owner = llGetOwner();
        Channel = ((integer) ("0x" + llGetSubString((string) llGetKey(), -8, -1)) & 0x3FFFFFFF) ^ 0xBFFFFFFF;
    }

    on_rez(integer start_param)
    {
        llResetScript();
    }

    touch_start(integer total_number)
    {
        llSensor("", "", AGENT, 96.0, PI);
    }

    sensor(integer detected)
    {
        DetectedTotal = detected;

        if (detected <= 9) DetectedNames1 = [detected];
        else DetectedNames1 = [9];
        if (detected > 9) DetectedNames2 = [detected - 9];
        else DetectedNames2 = [0];

        integer user = 0;
        integer button_label = 1;
        key uuid;
        string legacy_name;
        string display_name;
        string counter;
        string name;
        while(detected--) {
            uuid = llDetectedKey(detected);
            legacy_name = llDetectedName(detected);
            display_name = llGetDisplayName(uuid);

            counter = "A" + (string) button_label;
            if (user < 9) counter = "A0" + (string) button_label;

            name = counter + ": " + legacy_name;
            if (display_name) name = counter + ": " + display_name + " (" + legacy_name + ")";

            if (user < 9) {
                DetectedNames1 += name;
                DetectedNames1 += uuid;
            } else {
                DetectedNames2 += name;
                DetectedNames2 += uuid;
            }

            user++;
            button_label++;
        }

        page1Menu();
    }

    no_sensor()
    {
        setupListener();

        llDialog(Owner, "\nthere are no others in range\n\n", ["other", "refresh"], Channel);
    }

    listen(integer chan, string name, key id, string msg)
    {
        if (msg == "refresh" || msg == "page 1") llSensor("", "", AGENT, 96.0, PI);
        else if (msg == "page 2") page2Menu();
        else if (msg == "other") otherMenu();
        else if (msg == "A01") printReport(llList2Key(DetectedNames1, 2));
        else if (msg == "A02") printReport(llList2Key(DetectedNames1, 4));
        else if (msg == "A03") printReport(llList2Key(DetectedNames1, 6));
        else if (msg == "A04") printReport(llList2Key(DetectedNames1, 8));
        else if (msg == "A05") printReport(llList2Key(DetectedNames1, 10));
        else if (msg == "A06") printReport(llList2Key(DetectedNames1, 12));
        else if (msg == "A07") printReport(llList2Key(DetectedNames1, 14));
        else if (msg == "A08") printReport(llList2Key(DetectedNames1, 16));
        else if (msg == "A09") printReport(llList2Key(DetectedNames1, 18));
        else if (msg == "A10") printReport(llList2Key(DetectedNames2, 2));
        else if (msg == "A11") printReport(llList2Key(DetectedNames2, 4));
        else if (msg == "A12") printReport(llList2Key(DetectedNames2, 6));
        else if (msg == "A13") printReport(llList2Key(DetectedNames2, 8));
        else if (msg == "A14") printReport(llList2Key(DetectedNames2, 10));
        else if (msg == "A15") printReport(llList2Key(DetectedNames2, 12));
        else if (msg == "A16") printReport(llList2Key(DetectedNames2, 14));
        else {
            if (llKey2Name(msg) == "") {
                UuidNotFound = TRUE;
                otherMenu();
            } else printReport(msg);
        }
    }

    timer()
    {
        if (ListenerTimeElapsed == 60) cleanupListener();
        else ListenerTimeElapsed++;
    }
}
