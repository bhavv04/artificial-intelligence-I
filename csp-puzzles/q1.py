

# This first list shows the travel times between each pair of customers and the warehouse
# For example, travel_times[5][10] will return to the travel time in minutes between customers
# c5 and c10. Index 0 corresponds to the warehouse.
# Note that the travel time between a customer and itself is set as 0, but your delivery
# truck should never repeat the same customer more than once
# Also notice that travel_times is symmetric, and so travel_times[5][10] == travel_times[10][5]
# since the time is the same in either direction.
travel_times = [
    [0, 100, 50, 70, 30, 45, 32, 56, 40, 45, 40, 18, 20, 30, 26, 35, 20, 5, 40],  # warehouse to other customers
    [100, 0, 25, 75, 35, 55, 45, 105, 40, 30, 25, 5, 15, 20, 15, 10, 25, 18, 10],  # c1 to other customers
    [50, 25, 0, 35, 27, 50, 25, 45, 75, 20, 10, 45, 20, 56, 19, 35, 70, 25, 35],  # c2 to other customers
    [70, 75, 35, 0, 15, 54, 40, 10, 15, 90, 10, 10, 10, 34, 35, 20, 15, 10, 40],  # c3 to other customers
    [30, 35, 27, 15, 0, 25, 30, 35, 25, 23, 25, 20, 50, 19, 45, 45, 25, 30, 10],  # c4 to other customers
    [45, 55, 50, 54, 25, 0, 100, 25, 67, 20, 30, 5, 25, 20, 70, 26, 40, 10, 15],  # c5 to other customers
    [32, 45, 25, 40, 30, 100, 0, 25, 25, 50, 45, 100, 10, 34, 10, 30, 5, 56, 25],  # c6 to other customers
    [56, 105, 45, 10, 35, 25, 25, 0, 15, 45, 60, 10, 35, 45, 15, 15, 20, 32, 20],  # c7 to other customers
    [40, 40, 75, 15, 25, 67, 25, 15, 0, 20, 90, 40, 17, 34, 15, 25, 20, 15, 70],  # c8 to other customers
    [45, 30, 20, 90, 23, 20, 50, 45, 20, 0, 35, 60, 15, 10, 9, 15, 15, 100, 35],  # c9 to other customers
    [40, 25, 10, 10, 25, 30, 45, 60, 90, 35, 0, 15, 18, 20, 40, 70, 25, 45, 30],  # c10 to other customers
    [18, 5, 45, 10, 20, 5, 100, 10, 40, 60, 15, 0, 15, 20, 30, 30, 15, 20, 20],  # c11 to other customers
    [20, 15, 20, 10, 50, 25, 10, 35, 17, 15, 18, 15, 0, 45, 40, 20, 20, 10, 25],  # c12 to other customers
    [30, 20, 56, 34, 19, 20, 34, 45, 34, 10, 20, 20, 45, 0, 20, 10, 19, 16, 15],  # c13 to other customers
    [26, 15, 19, 35, 45, 70, 10, 15, 15, 9, 40, 30, 40, 20, 0, 5, 15, 10, 15],  # c14 to other customers
    [35, 10, 35, 20, 45, 26, 30, 15, 25, 15, 70, 30, 20, 10, 5, 0, 20, 40, 30],  # c15 to other customers
    [20, 25, 70, 15, 25, 40, 5, 20, 20, 15, 25, 15, 20, 19, 15, 20, 0, 30, 15],  # c16 to other customers
    [5, 18, 25, 10, 30, 10, 56, 32, 15, 100, 45, 20, 10, 16, 10, 40, 30, 0, 40],  # c17 to other customers
    [40, 10, 35, 40, 10, 15, 25, 20, 70, 35, 30, 20, 25, 15, 15, 30, 15, 40, 0],  # c18 to other customers
]

# This next list shows the time windows for each customer.
# For example, the window at index 5 is for customer c6.
# The window is given as a list of two elements where the
# first is the start time and the second is the end time.
# For example, c6 has the window [200, 320) given the list
# below.
# Remember that the start time is inclusive and the end time
# is not.
windows = [
    [90, 150],  # c1
    [200, 400],  # c2
    [60, 180],  # c3
    [60, 120],  # c4
    [150, 200],  # c5
    [200, 320],  # c6
    [200, 320],  # c7
    [330, 460],  # c8
    [300, 360],  # c9
    [510, 600],  # c10
    [420, 500],  # c11
    [420, 480],  # c12
    [510, 600],  # c13
    [360, 420],  # c14
    [360, 400],  # c15
    [480, 600],  # c16
    [410, 480],  # c17
    [510, 600],  # c18
]

with open("q1_kb.pl", "w") as f:
    for i in range(len(travel_times)):
        for j in range(len(travel_times)):
            f.write(f"travel_time({"w" if i == 0 else 'c'+str(i)}, {"w" if j == 0 else 'c'+str(j)}, {travel_times[i][j]}).\n")
    
    f.write('\n')
    
    for i in range(len(windows)):
        f.write(f"window(c{i+1}, {windows[i][0]}, {windows[i][1]}).\n")