# File02_ListComprehension.py

s = [1, 2, 3, 4, 5]

# s2 = [2, 4, 6, 8, 10]

s2 = []
for n in s:
    if n < 3:
        s2.append(n * 2)
print(s2)

s3 = [n * 2 for n in s if n < 3]
print(s3)


