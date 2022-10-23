# RISCV-32I Single Cycle Processor

This basic design supports six base instructions mentioned as:

- R-Type
- I-Type
- S-Type
- B-Type
- J-Type
- U-type

All above instructions are 32 bits encoding based.

## DataPath 

In order to implement B-type U-type and J-Type I did some ammendments according to the requirements but the main underlying datapath is same which is provided below.

![image](https://user-images.githubusercontent.com/104595329/197416834-bcc748b4-37fa-4ef3-b8af-6382d945a948.png)

## Simulation

For Simulation I have used QuestaSim,and I have also uploaded my complete project folder with name project. If you have QuestaSim setup istalled in your computer you can simply download this folder and can run RV32I.mpf file inside project folder.
If you want to make your own project then you need to make a new project and all the modules that are in RTL folder add them as design source
  
##  Testing

For Testing purposes I have added gcd.s assembely file which calculates the GCD of two given numbers 

![image](https://user-images.githubusercontent.com/104595329/197416151-393dc260-e1c0-4e93-90ad-f333fb8c155b.png)

The value stored in x8 is 10 and for x9 is 50 the above algorithm calculates the GCD of two numbers and store the result calculated in register file x10.For verification purpose the algorithm has been tested in [Venus](https://venus.kvakil.me/) and the result obtained is shown as below

![Venus output ](https://user-images.githubusercontent.com/104595329/197414793-5680a17d-1f04-44a1-a995-cdb67c718028.png)

After running these assembly instructions in QuestaSim the same result has been obtained

![Output 3](https://user-images.githubusercontent.com/104595329/197414772-f820b91b-b5ae-40e5-ae26-f04ec3e59e60.png)
![Output 4](https://user-images.githubusercontent.com/104595329/197414788-29261201-a37f-4e3c-b788-ff2b62b19d32.png)

![Output 5](https://user-images.githubusercontent.com/104595329/197414791-3a07c12a-dda9-40c8-b40e-1f42dc83b055.png)

The GCD of 5 and 50 is calculated as 10 and is stored back in register x10



## Reference

Some part of this material and understanding is taken from book " Digital Design and Computer Architecture RISC-V Edition " by Sarah L Harris and David M Harris.
