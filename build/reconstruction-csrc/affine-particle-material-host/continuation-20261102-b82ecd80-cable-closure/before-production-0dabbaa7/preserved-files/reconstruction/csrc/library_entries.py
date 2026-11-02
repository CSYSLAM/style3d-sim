"""Library entry extraction including ordinary .entry declarations omitted by the owned-kernel census."""
import re

ENTRY = re.compile(r'^[ \t]*(?:(?:\.visible|\.weak)\s+)?\.entry\s+(\w+)\(', re.M)


def entries(text):
    result = {}
    for match in ENTRY.finditer(text):
        begin = text.index('{', match.end())
        depth = 0
        for at in range(begin, len(text)):
            depth += (text[at] == '{') - (text[at] == '}')
            if depth == 0:
                result[match[1]] = text[match.start():at + 1]
                break
        else:
            raise ValueError('Unclosed PTX entry: ' + match[1])
    return result
