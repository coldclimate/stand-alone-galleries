import glob, os
from PIL import Image
from jinja2 import FileSystemLoader,  Environment
from shutil import copyfile

size = 280, 280

context = {
    "TITLE":"PUT YOUR TITLE HERE",
    "INTRO":"PUT YOUR INTRO HERE"
} 


if not os.path.exists("output/images/fullsize"):
    os.makedirs("output/images/fullsize")

if not os.path.exists("output/images/thumbs"):
    os.makedirs("output/images/thumbs")

os.chdir("input")
files=glob.glob("*.JPG")
context["images"] = sorted(files)


for file in files:
    try:
        outfile = "../output/images/thumbs/" + file
        im = Image.open(file)
        im.thumbnail(size, Image.ANTIALIAS)
        im.save(outfile, "JPEG")
        copyfile(file, "../output/images/fullsize/"+file)
    except IOError:
        print "cannot create thumbnail for '%s'" % file
os.chdir("../")
PATH = os.path.dirname(os.path.abspath(__file__))
TEMPLATE_ENVIRONMENT = Environment(
    autoescape=False,
    loader=FileSystemLoader(os.path.join(PATH, 'templates')),
    trim_blocks=False)

with open("output/index.html", 'w') as f:
        html = TEMPLATE_ENVIRONMENT.get_template("page.html").render(context)
        f.write(html)