import pandas as pd

def day_1_1(file_path: str = '/Users/radi.radev/Projects/aoc/day_1.txt'):
    df = pd.read_csv(file_path, sep='   ' ,names=['col_1', 'col_2'])
    df_sort = pd.DataFrame({col: df[col].sort_values().values for col in df})
    df_sort['col_3'] = (df_sort['col_1'] - df_sort['col_2']).abs()
    
    return df_sort['col_3'].sum()


def day_1_2(file_path: str = '/Users/radi.radev/Projects/aoc/day_1.txt'):
    df = pd.read_csv(file_path, sep='   ' ,names=['col_1', 'col_2'])
    df['col_result'] = (df['col_1'].apply(lambda x: (df['col_2'] == x).sum())) * df['col_1']
    
    return df['col_result'].sum()
