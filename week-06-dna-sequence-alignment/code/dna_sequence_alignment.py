import argparse
import os
import numpy as np
from dp_matrix import DPmatrix


"""
BiS301 Lab6. DNA Sequence Alignment

Example sequences:
    - example 1: TTCATA, TGCTCGTA
    - example 2: TTCCG, TAACTCG
"""


def get_arguments():
    """Parse all the arguments provided from the CLI.
    Returns:
      A list of parsed arguments.
    """
    parser = argparse.ArgumentParser(description="BiS301 Lab6")
    parser.add_argument("--sequence_1", type=str, default='ATGACCGTAATAGGT', required=False)
    parser.add_argument("--sequence_2", type=str, default='AACCTTGTCT', required=False)
    return parser.parse_args()

def main(args):
    seq1 = args.sequence_1
    seq2 = args.sequence_2
    print('Sequence 1: ', seq1)
    print('Sequence 2: ', seq2)

    mat = DPmatrix(seq1, seq2)
    mat.fill_in_DPmat()

    print('Score matrix: ')
    print(mat.score_matrix)

    mat.trace_back(len(seq1), len(seq2), len(seq2))
    print('Finished alignment')
    return


if __name__ == '__main__':
    args = get_arguments()

    main(args)
