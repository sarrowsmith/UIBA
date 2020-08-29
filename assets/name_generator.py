#!/usr/bin/python3

import unicodedata
import json

adjectives = []
for n in range(0x25AA, 0x2B56):
    a_chr = chr(n)
    try:
        adjective = unicodedata.name(a_chr)
    except ValueError:
        continue
    short = " %s " % adjective
    for never in ("BRAILLE",):
        short = short.replace(" %s " % never, "!")
    if short.count("!") > 0:
        continue
    for omit in ("WHITE", "BLACK", "CHESS", "SUIT", "DIE", "MUSIC",
        "MONOGRAM FOR", "DIGRAM FOR", "TRIGRAM FOR", "CROSS OF",
        "SYMBOL", "SIGN", "MARK", "CIRCLED", "ARROW", "ORNAMENT"):
        short = short.replace(" %s " % omit, " ")
    short = short.replace("  ", " ").replace(" -", " ").strip().strip("-")
    if len(short) > 30:
        continue
    adjectives.append([adjective, a_chr, short.title()])

nouns = []
for n in range(0x1F300, 0x1FA96):
    n_chr = chr(n)
    try:
        noun = unicodedata.name(n_chr)
    except ValueError:
        continue
    short = " %s " % noun
    for never in ("EMOJI", "INPUT",
        "CHESS", "XIANGQI"): # No glyphs for these in Noto font
        short = short.replace(" %s " % never, "!")
    if short.count("!") > 0:
        continue
    for omit in ("BLACK", "WHITE", "SYMBOL", " SIGN", "INDEX",
        "CLOCK FACE", "ALCHEMICAL FOR"):
        short = short.replace(" %s " % omit, " ")
    short = short.replace(" AND ", " & ").replace("  ", " ").replace(" -", " ").strip().strip("-")
    if len(short) > 30:
        continue
    nouns.append([noun, n_chr, short.title()])

everything = {"adjectives": adjectives, "nouns": nouns}
print(json.dumps(everything, indent=2))
