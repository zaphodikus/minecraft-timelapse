# exports an autohotkey script containing macros or emoticons for Steam forum and chat
# for all keys that have more than one emoji, the script randomly exports one from a list
# CTRL-J ends the script
import random

template_start = """
; https://steamcommunity.com/sharedfiles/filedetails/?id=1116206612
#NoEnv
#Persistent
#SingleInstance
SendMode Input
"""
template_end = """
:*: :::{Space}{Space}{Space}{Space}{Space}{Space}{Space}
f12::
Suspend, Toggle
return
^r::
Suspend, On
Reload
"""
template_hotkey = ":{0}:::{1}:"
data = {
    "a": ["csgoa", "ADynamic"],
    "b": ["blastshot"],
    "c": ["code_v2"],
    "d": ["deadlyd",  "_D_"],
    "e": ["FreebieE3"],
    "f": ["FLAME_SHOT"],
    "g": ["gnomoria",  "gmod"],
    "h": ["hhazard",  "hydrogen"],
    "i": ["iiii"],
    "j": ["_J_"],
    "k": ["civilwarsoldier", "campkiller"],
    "l": ["lasershot", "tetra_L"],
    "m": ["justM"], #
    "n": ["NletterNKOA",  "nitrogen"],
    "o": ["orbitalxsaturn",  "p2blue", "xenon"],
    "p": ["power_sub", "pawsp"],
    "q": ["_Q_"],
    "r": ["FreebieR"], #
    "s": ["supergirlemblem",  "sgsurvivor", "spatula",  "2018bestaward"],
    "t": ["tyger",  "justT", "dw_hammer"],
    "u": ["iq2",  "s3khukuri",  "latteru"],
    "v": ["isi"],
    "w": ["wh"],
    "x": ["dieHoPiKo"],
    "y": ["TFT_buck"],
    "z": ["nary_letter", "NZA2_Zed", "spatula", "dragp", "zssz", "_Z_"],

    "0": ["xenon"],
    "1": ["emo1"],
    "5": ["lifepod"],
}


def generate_emoji_script(file_name):
    """
    Saves an AHK script usign randomly choosen emojis for key if it has more than one emoji
    :param file_name:
    :return:
    """
    with open(file_name, mode='w') as file:
        file.write(template_start + "\n")
        for k in data:
            idx = random.randrange(0, len(data[k]))
            file.write(template_hotkey.format(k, data[k][idx]) + "\n")
        file.write(template_end +"\n")


generate_emoji_script('D:\\src\\python\\ahk\\gsteam_emojis.ahk')
