from params import score_rule, gap_penalty
import numpy as np


char_dict = {'A': 0, 'R': 1, 'N': 2, 'D': 3, 'C': 4, 
             'Q': 5, 'E': 6, 'G': 7, 'H': 8, 'I': 9, 
             'L':10, 'K':11, 'M':12, 'F':13, 'P':14, 
             'S':15, 'T':16, 'W':17, 'Y':18, 'V':19, '-':20}

int_dict = {0: 'A', 1: 'R', 2: 'N', 3: 'D', 4: 'C',
            5: 'Q', 6: 'E', 7: 'G', 8: 'H', 9: 'I',
           10: 'L',11: 'K',12: 'M',13: 'F',14: 'P',
           15: 'S',16: 'T',17: 'W',18: 'Y',19: 'V', 20: '-'}


class DPmatrix(object):
    # Feel free to use this attributions
    go_left = 0
    go_diag = 1
    go_up = 2
    stop = 3
    
    def __init__(self, seq1, seq2, name):
        
        self.seq1 = seq1
        self.seq2 = seq2
        self.name = name
        
        self.score_matrix = np.zeros((len(seq1)+1, len(seq2)+1))
        self.flag_matrix = np.zeros((len(seq1)+1, len(seq2)+1, 4))
        
        self.fill_in_DPmat()
        self.trace_back()
        self.check_similarity()
        #self.print_alignment()
        
        
    def chr2int(self, character):
        if character in char_dict:
            return char_dict[character]
        else:
            raise ValueError('Input character is not valid')
            
            
    def int2char(self, number):
        if number in int_dict:
            return int_dict[number]
        else:
            raise ValueError('Input number is not valid')
            
            
    def obtain_score(self, i, j):
        return self.score_matrix[i][j]
    
    
    def obtain_flag(self, i, j):
        return self.flag_matrix[i][j]
    
    
    def get_score(self, i, j):
        return score_rule[self.chr2int(self.seq1[i-1]),
                          self.chr2int(self.seq2[j-1])]
    
    
    def fill_in_DPmat(self):
        """
        self.flag_matrix[i][j] = [case1 case2 case3 case4], where each case is 0(false) or 1(true)
        case 1 : from left (j matched with a gap) -> S(i, j-1) - gap_penalty
        case 2 : from diagonal (i, j matched) -> S(i-1, j-1) + s(i, j)
        case 3 : from above (i matched with a gap) -> S(i-1, j) - gap_penalty
        case 4 : score 0 or less -> 0
        Use score_rule and gap_penalty for S(i,j) and 4 relatively.


        Recommended steps
        
        1. Initialize the first row and the first column of self.score_matrix and self.flag_matrix
        2. fill in remaining value of each matrix with a score (S(i,j)) and a direction (flg(i,j))
        3. To get a score(S(i,j)) and a direction(flg(i,j)) of a cell[i,j], do following steps
            1st step: calculate four scores
                      case 1: S(i, j-1) - gap_penalty
                      case 2: S(i-1, j-1) + s(i, j)
                      case 3: S(i-1, j) - gap_penalty
                      case 4: 0
            2nd step: compare four scores and take the highest one
            3rd step: save the highest score as score(S(i,j)) and its direction
        """
        self.flag_matrix[0,:,3] = 1
        self.flag_matrix[:,0,3] = 1
        
        for i in range(1, len(self.seq1)+1):
            for j in range(1, len(self.seq2)+1):
                score = np.array((self.score_matrix[i, j-1] + gap_penalty,self.score_matrix[i-1, j-1] + self.get_score(i, j), self.score_matrix[i-1, j] + gap_penalty, 0))
                max = int(score.max())
                self.score_matrix[i][j] = max
                dir = score == max
                for k in range(4): self.flag_matrix[i][j][k] = dir[k]
                
    def trace_back(self):
        """
        traceback the direction from self.flag_matrix by RECURSIVE process
        modify self.result while tracing and print out final result at the end of tracing with self.print_result()
        
        Recomended steps
        1. Find the starting point of the local alignment from self.score_matrix.
        2. Traceback alignment until the score is greater than or equal to zero.
        """
        
        # Set-up for alignment
        align1 = ''
        align2 = ''

        self.align1 = align1
        self.align2 = align2
        
        trace_back_i = self.score_matrix.argmax()//self.score_matrix.shape[-1]
        trace_back_j = self.score_matrix.argmax()%self.score_matrix.shape[-1]
        
        while trace_back_i > 0 and trace_back_j > 0:
            if self.flag_matrix[trace_back_i][trace_back_j][0] == 1:
                trace_back_j -= 1
                align1 += '-'
                align2 += self.seq2[trace_back_j]
            if self.flag_matrix[trace_back_i][trace_back_j][1] == 1:
                trace_back_i -= 1
                trace_back_j -= 1
                align1 += self.seq1[trace_back_i]
                align2 += self.seq2[trace_back_j]
            if self.flag_matrix[trace_back_i][trace_back_j][2] == 1:
                trace_back_i -= 1
                align1 += self.seq1[trace_back_i]
                align2 += '-'
            if self.flag_matrix[trace_back_i][trace_back_j][3] == 1:
                break
        
        self.align1 = align1[::-1]
        self.align2 = align2[::-1]

    def check_similarity(self):
        """
        This function is given to analyze the similarity of the two sequence alignment
        """
        result = ''
        for res1, res2 in zip(self.align1, self.align2):
            if res1 == res2:
                result += '|'        # same pair
            elif (res1 == '-') or (res2 == '-'):
                result += ' '        # gap
            else:
                idx1 = char_dict[res1]
                idx2 = char_dict[res2]
                score = score_rule[idx1, idx2]
                if score > 0:
                    result += ':'    # similar pair
                else:
                    result += '.'    # dissimilar pair
        self.similarity = result            
        
    
    def print_alignment(self):
        """
        This function is given to visualize the similarity of the two sequence alignment
        """
        print(f'The alignment for query and {self.name} score is {self.score_matrix.max()} \n')
        for i in range(len(self.align1)//60 + 1):
            start = i * 60
            end = min((i+1)*60, len(self.align1))
            
            print(f'query : {self.align1[start: end]}')
            print(f'        {self.similarity[start:end]}')
            print(f'{self.name}: {self.align2[start:end]}\n')
