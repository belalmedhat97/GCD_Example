# GCD_Example
In this example it show how to use GCD (Grand Central Dispatch) using Serial Queue and Concurrent Queue and showing the effect of serial and concurrent using UIProgressView and UILabel 

## Explination
in serial queue the 3 progressview started in FIFO(first in first out) order where task 1 start then task 2 and at last task 3 

[![2b9XKQ.md.png](https://iili.io/2b9XKQ.md.png)](https://freeimage.host/i/2b9XKQ)

#
#
in concurrent queue the 3 progressview started in FIFO(first in first out) order where task 1 starts then task 2 and at last task 3 but here the The exact number of tasks that can be executed at any given instance is variable and is dependent on the system's current conditions and resources. 
The decision on when to start a task is up to GCD

[![2b9jUB.md.png](https://iili.io/2b9jUB.md.png)](https://freeimage.host/i/2b9jUB)

## GIF 
![](https://media.giphy.com/media/Jk3fZ1jwNd0sr4Fo7h/giphy.gif)
