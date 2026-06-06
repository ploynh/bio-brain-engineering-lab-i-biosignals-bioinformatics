import numpy as np
from param import score_rule, gap_penalty

class DPmatrix(object):
    # Feel free to use this attributions
    go_left = 0
    go_diag = 1
    go_up = 2

    def __init__(self, seq1, seq2):
        """
        Goal: Implements fill_in_DPmat() and trace_back()
        1. Note that trace_back function should be implemented in recursive way
        2. Use score_rule and gap_penalty defined in param.py
        3. Modifying other parts is not allowed without specific reasons
            - Feel free to use other functions as-is
        """
        self.seq1 = seq1
        self.seq2 = seq2

        self.score_matrix = np.zeros((len(seq1)+1, len(seq2)+1))
        self.flag_matrix = np.zeros((len(seq1)+1, len(seq2)+1, 3)) # 0: go_left, 1: go_diag, 2: go_up
        self.flag_matrix[0][0] = np.array([None for _ in range(3)]) # Null flag
        self.result = np.empty(len(seq2)) # Initialize final aligned sequence

    def chr2int(self, character):
        if character == '-':
            return 0
        if character.upper() == 'A':
            return 1
        elif character.upper() == 'T':
            return 2
        elif character.upper() == 'G':
            return 3
        elif character.upper() == 'C':
            return 4
        else:
            raise ValueError('Input character is not valid')

    def int2chr(self, number):
        if number == 0:
            return '-'
        elif number == 1:
            return 'A'
        elif number == 2:
            return 'T'
        elif number == 3:
            return 'G'
        elif number == 4:
            return 'C'
        else:
            raise ValueError('Input number is not valid')

    def obtain_score(self, i, j):
        return self.score_matrix[i][j]

    def obtain_flag(self, i, j):
        return self.flag_matrix[i][j]

    def fill_in_DPmat(self):
        """
        self.flag_matrix[i][j] = [case1 case2 case3], where each case is 0(false) or 1(true)
        case 1 : from left (j matched with a gap) -> S(i, j-1) - 6
        case 2 : from diagonal (i, j matched) -> S(i-1, j-1) + s(i, j)
        case 3 : from above (i matched with a gap) -> S(i-1, j) - 6
        Use score_rule and gap_penalty for S(i,j) and -6 relatively.


        Recommended steps

        1. Initialize the first row and the first column of self.score_matrix and self.flag_matrix
        2. fill in the remaining values of each matrix with a score(S(i,j)) and a direction(flg(i,j))
        3. To get a score(S(i,j)) and a direction(flg(i,j)) of a cell[i,j], do following steps
            1st step: calculate three scores(S(i-1, j-1) + s(i,j), S(i-1,j)-6, S(i,j-1)-6)
            2nd step: compare three scores and take the highest one
            3rd step: save the highest score as score(S(i,j)) and its direction
        """

        for i in range(len(self.seq1)):
            self.score_matrix[i+1][0] = gap_penalty + self.score_matrix[i][0]
            self.flag_matrix[i+1][0][2] = 1

        for i in range(len(self.seq2)):
            self.score_matrix[0][i+1] = gap_penalty + self.score_matrix[0][i]
            self.flag_matrix[0][i+1][0] = 1

        for i in range(len(self.seq1)):
            for j in range(len(self.seq2)):
                from_left = self.score_matrix[i+1][j] + gap_penalty
                from_diag = score_rule[self.chr2int(self.seq1[i])-1][self.chr2int(self.seq2[j])-1] + self.score_matrix[i][j]
                from_above = self.score_matrix[i][j+1] + gap_penalty

                if from_left >= from_diag and from_left >= from_above:
                    self.score_matrix[i+1][j+1] = from_left
                    self.flag_matrix[i+1][j+1][0] = 1
                if from_diag >= from_left and from_diag >= from_above:
                    self.score_matrix[i+1][j+1] = from_diag
                    self.flag_matrix[i+1][j+1][1] = 1
                if from_above >= from_left and from_above >= from_diag:
                    self.score_matrix[i+1][j+1] = from_above
                    self.flag_matrix[i+1][j+1][2] = 1

    def trace_back(self, trace_back_i, trace_back_j, trace_back_cnt):
        """
        trace back the direction from self.flag_matrix by RECURSIVE process
        modify self.result while tracing and print out final result at the end of tracing with self.print_result()
        """

        if trace_back_cnt == 0:
            self.print_result()
        else:
            if self.flag_matrix[trace_back_i][trace_back_j][0] == 1:
                self.result[trace_back_cnt-1] = 0
                self.trace_back(trace_back_i, trace_back_j-1, trace_back_cnt-1)
            if self.flag_matrix[trace_back_i][trace_back_j][1] == 1:
                self.result[trace_back_cnt-1] = self.chr2int(self.seq1[trace_back_i-1])
                self.trace_back(trace_back_i-1, trace_back_j-1, trace_back_cnt-1)
            if self.flag_matrix[trace_back_i][trace_back_j][2] == 1:
                self.result[trace_back_cnt-1] = self.chr2int(self.seq1[trace_back_i-1])
                self.trace_back(trace_back_i-1, trace_back_j, trace_back_cnt-1)
        return

    def print_result(self):
        result_str = [self.int2chr(x) for x in self.result]
        result_str = ''.join(result_str)
        print('result: ', result_str)
        print('score: ', self.score_matrix[len(self.seq1)][len(self.seq2)])




