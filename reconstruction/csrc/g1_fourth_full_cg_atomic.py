"""Certify the 1000 real reduction inputs captured across five nonlinear solves in one G1 substep."""
from . import g1_nl2_full_cg_atomic as previous
from .g1_nl2_full_cg import replace_once


BASE_WORKER = previous.rendered_worker


def rendered_worker():
    text = BASE_WORKER()
    text = replace_once(text, "            kind = key.split('_', 1)[0]",
                        "            kind = key.split('-', 1)[1].split('_', 1)[0]")
    assert text.count("key.startswith('precondition')") == 2
    text = text.replace("key.startswith('precondition')", "kind == 'precondition'")
    text = replace_once(text, "len(plan['cases']) == 200", "len(plan['cases']) == 1000")
    text = replace_once(text, "calls['probe'] == 400 and calls['SDK_isolation'] == 1200",
                        "calls['probe'] == 2000 and calls['SDK_isolation'] == 6000")
    return text


def main():
    previous.rendered_worker = rendered_worker
    previous.main()


if __name__ == '__main__':
    main()
