# ShellXploit
ShellXploit is an automatic payload msfvenom generator (APMG) with **Out of LAN** connections. That means that ShellXploit has the ability to create reverse shells and connect it to the target without staying on the same network.


ShellXploit is a fantastic tool to use with Social Engineering Techniques to gain quick access to a system without staying on the same network with your target. Thanks to port forwarding over port 80, ShellXploit can establish a reverse shell outside of LAN.

# Setup
The setup of this tool is very easy. Just give execution permission to `setup.sh` and `shellxploit.sh`:

- `chmod +x setup.sh`
- `chmod +x shellxploit.sh`

# How to use
Learn how ShellXploit works! =)
## How to use setup.sh
Before running `shellxploit.sh`, you need to run` setup.sh` for forwarding port 80 on this website: https://localhost.run/

The script will search the tools needed, if the tools are not found, `setup.sh` will install them.
**It is recommended to run it with root privileges.**

Once you had executed port 80 simply copy the link it gives you.

![Captura](https://user-images.githubusercontent.com/76668073/136985337-dccf75a7-6ae9-4afb-b0ee-411d4f54c120.PNG)

**WARNING! DO NOT CLOSE THE SCRIPT. JUST LEAVE RUNNING, IF THE PROCESS IS TERMINATED, THE SSH CONNECTION WILL TERMINATE. AND IT WILL NOT WORK!**

## How to use shellxploit.sh
The interface of tool is really simple. Just you can check how to use with `shellxploit.sh -h`

![image](https://user-images.githubusercontent.com/76668073/136986191-347eac58-4987-40db-a07a-60422dbe352c.png)

Just give **in this order** the next parameters: `shellxploit.sh <PLATFORM> <IP>`:

![image](https://user-images.githubusercontent.com/76668073/136986505-81caff48-d651-4baa-bc31-d9627cc70303.png)

Once you selected one of the platforms and had pasted the link. Hit enter and ShellXploit will generate the payload.

![image](https://user-images.githubusercontent.com/76668073/136987766-759f1eb3-f5f4-43f8-984c-3abff677daac.png)

Finally it will ask you if you want to configure the listener, it will call msfconsole and automatically configure the listener.

![image](https://user-images.githubusercontent.com/76668073/136987260-ef28f1be-9358-4354-95d0-9c72b006d543.png)

And now you just have to wait that your target execute the payload.

# To Do (ShellXploit v2.0.0)
- Avoid Virus Detection
- Certified Spoofing
- Automatic Loop Payload Generator
