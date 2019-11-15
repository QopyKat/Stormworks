
import argparse
from enum import Enum

parser = argparse.ArgumentParser(description="Minify Argument Parser")
parser.add_argument('-f', action='store_true', help='Minify defined functions')
parser.add_argument('-o', metavar='outfile', type=str, nargs=1, help='Output File')
parser.add_argument('filename', nargs=1, help='Lua File to parse')

KEYWORDS = [
    'and', 'break', 'do', 'else', 'elseif', 'end', 'false',
    'for', 'function', 'if', 'in', 'local', 'nil', 'not',
    'or', 'repeat', 'return', 'then', 'true', 'until', 'while'
]
TOKENS = [
    '+', '-', '*', '/', '%', '^', '#', '==', '~=', '<=', '>=', '<', '>', '=',
    '(', ')', '{', '}', '[', ']', ';', ':', ',', '.', '..', '...',
]
SPACES = [
    ' ', '\t', '\n', '\r'
]
NEW_LINE = [
    '\n', '\r'
]
COMMENT = '--'
ML_COMMENT_BEGIN = '[['
ML_COMMENT_END = ']]'

class TYPE(Enum):
    KEYWORD = 0
    TOKEN = 1
    NAME = 2
    INT = 3
    FLOAT = 3
    STRING = 3

def isint(s):
    try:
        int(s)
        return True
    except:
        return False

def isfloat(s):
    try:
        float(s)
        return True
    except:
        return False

class VALUE:
    def __init__(self, value):
        if value in KEYWORDS:
            self.value = value
            self.type = TYPE.KEYWORD
        elif value in TOKENS:
            self.value = value
            self.type = TYPE.TOKEN
        elif isint(value):
            self.value = int(value)
            self.type = TYPE.INT
        elif isfloat(value):
            self.value = float(value)
            self.type = TYPE.FLOAT
        else:
            self.value = value
            self.type = TYPE.STRING

def exitMsg(msg):
    print(msg)
    exit(0)


def parseFile(text: str):
    values = list()
    begin = 0
    end = 0

    print(text)

    while begin < len(text):
        while begin < len(text) and text[begin] in SPACES:
            begin += 1
        if begin >= len(text):
            break

        if text[begin] == '"':
            end = text.find('"', begin + 1) + 1
            if end == len(text):
                exitMsg('String did not end')
            values.append(VALUE(text[begin : end]))
        elif text[begin : begin + 2] == '--':
            if begin + 3 < len(text) and text[begin + 2 : begin + 4] == '[[':
                end = text.find(']]', begin + 1) + 2
            else:
                end = text.find('\n', begin + 1) + 1
        elif text[begin] in TOKENS:
            end = begin + 1
            values.append(VALUE(text[begin : end]))
        else:
            end = begin + 1
            while end < len(text) and text[end] not in SPACES and text[end] not in TOKENS:
                end += 1
            values.append(VALUE(text[begin : end]))
        begin = end

    return values


args = parser.parse_args()
print(args)
# Namespace(f=False, filename=['in.lua'], o=['out.lua'])
# Namespace(f=False, filename=['in.lua'], o=None)
# print(args.f) = False
# print(args.o) = None

filename = args.filename[0]
with open(filename) as file:
    tokens = parseFile(file.read())
    for token in tokens:
        print('%-7s: %s' % (token.type.name, str(token.value)))

