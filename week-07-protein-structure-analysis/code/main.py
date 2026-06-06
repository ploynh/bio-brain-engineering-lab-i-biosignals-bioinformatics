from pathlib import Path

# Lab 7. Protein Structure Data Analysis
"""
Pre-lab activities

Find the most similar template to query sequence using dynamic programming algorithm
Fill out DPmat.py file and run this file
"""
### 1. Import Libraries
import DPmat
import numpy as np
from DPmat import DPmatrix
import pandas as pd
### 2. Read Database
# Setup query and database file path
code_dir = Path(__file__).resolve().parent
query_path = code_dir / "query.fa"
database_path = code_dir / "customDB.fa"

# read query fasta file
database = {}
with open(query_path, 'r') as rf:
    lines = rf.readlines()
    query = lines[-1][:-1]
print(f'Query sequence: {query}\n')
# read database fasta file
with open(database_path, 'r') as rf:
    lines = rf.readlines()
for idx, line in enumerate(lines):
    if '>' in line:
        name = line[1:-1]
        seq = lines[idx+1][:-1]
        database[name] = seq
        
print(f'Database file [{database_path}] with {len(database)} sequences.')
print(f'Last entry of the database: \n\tname: {name}\n\tsequence: {seq}')
### 3. Running dynamic sequence alignment
# Dynamic sequence alignment
results = {}                                              # Assign result in dictionary form
for name, seq in database.items():                        # Run Smith-waterman alignment for all sequence in database
    mat = DPmatrix(query, seq, name)
    mat.fill_in_DPmat()                                   # fill the Dynamic Programming matrix
    mat.trace_back()                                      # Execute trace-back function
    mat.check_similarity()                                # Calculate similarity for two sequences
    results[name] = {'score': mat.score_matrix.max(),
                     'align1': mat.align1,
                     'align2': mat.align2,
                     'similarity': mat.similarity}
print('Finished alignment')
# Check results
mat.print_alignment()       # This print_result function is given to visualize result
### 4. Sorting database by alignment score
num_print = 3                      # number of sequences to print result

df = pd.DataFrame(data=results).T
sorted_df = df.sort_values(by=['score'], ascending=False)
sorted_df['score'][:3]
### 5. Print result
def print_result(name, align1, align2, similarity, score):
    for i in range(len(align1)//60 + 1):
        start = i * 60
        end = min((i+1)*60, len(align1))

        print(f'{"Query":<20}: {align1[start: end]}')
        print(f'{"":20}  {similarity[start:end]}')
        print(f'{name:<20}: {align2[start:end]}\n')
for i in range(num_print):
    data = sorted_df.iloc[i]
    print(f'▶ Best {i+1} alignment for query and {data.name} score is {data.score}.\n')
    print_result(name=data.name,
                 align1=data.align1,
                 align2=data.align2,
                 similarity=data.similarity,
                 score=data.score)
