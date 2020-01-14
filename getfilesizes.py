#creates a tsv file with image file dimensions in a certain directory
import PIL
from PIL import Image
import os
a=os.listdir("dir")

logfile=open("sizeinfo.txt","a+")
for i in range(0,len(a)):
    im=Image.open(a[i])
    logfile.write("%s\t%s" % im.size)
    logfile.write("\t%s\n" % a[i])
    print(i)
logfile.close()
