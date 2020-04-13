#!python
#
import os
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from pymatgen.core.periodic_table import get_el_sp
from monty.serialization import loadfn

def add_text(ax, text=[123.2, 234.5, 546.9], fontsize=10, k=1.5):
    """
    Write list to the subplot (not include head)

    Parameter
        ax: matplotlib.axis
            The subplot axis
        text: list[content_can_be_turned_into_str]
            The content to be written into the subplot
        fontsize: int
            The fontsize
        k: float
            The factor for height of head
    Return
        None
    """
    n = len(text)
    for i in range(0, n):
        y = float(2*i + 1)/float(n+k)/2.
        ax.text(0.5, y, str(text.pop()), fontsize=fontsize, 
                horizontalalignment='center', verticalalignment='center')

def set_content(ax, textlist=[123.2, 234.5, 546.9], head='H', n_txt=3, fontsize=10, kfont=1.2, k=1.5, bkcolor='0.9'):
    """
    Write content to the subplot

    Parameter
        ax: matplotlib.axis
            The subplot axis
        text: list[content_can_be_turned_into_str]
            The content to be written into the subplot
        head: str
            The head of the subplot
        fontsize: int
            The fontsize
        kfont: float
            The factor for the font of the head
        k: float
            The factor for height of head
        bkcolor: color-like content
            The color of the background
    Return
        None
    """
    x = 0.5
    y = float((2.*n_txt+k)/(2.*n_txt+2.*k))
    textlist = ["%.2f" % texti for texti in textlist]
    ax.text(x, y, head, fontsize=int(kfont*fontsize), fontweight='bold', 
            horizontalalignment='center', verticalalignment='center')
    try:
        len(textlist)
        add_text(ax, text=textlist, fontsize=fontsize, k=k)
    except Exception as e:
        raise e        
    ax.set_xticks([])
    ax.set_yticks([])
    ax.set_facecolor(bkcolor)

def get_eleName(i_ele, eleOrd):
    """
    Get the element name

    Parameter
        i_ele: int (>0)
            The number of the elements show in the period table, from left to right and from top to bottom
               e.g. In the full period table, H: i_ele=1, He: i_ele=2, Hf: i_ele=58
        eleOrd: list[int]
            The list of the element order shown int the table (from left to right, from top to bottom)
    Return
        eleName: str
            The symbol of the element
    """
    ele_trueInd = eleOrd[i_ele-1]
    elemap = {104: "Rf", 105: "Db", 106: "Sg", 107: "Bh", 108: "Hs", 109: "Mt", 
          110: "Ds", 111: "Rg", 112: "Cn", 113: "Uut", 114: "Fl", 115: "Uup", 
          116: "Lv", 117: "Uus", 118: "Uuo"}
    if ele_trueInd < 104:
        eleName = get_el_sp(ele_trueInd)
    else:
        eleName = elemap[ele_trueInd]
    return eleName

def get_text(eleName, datafile="bcc-cij.json", test=False):
    """
    """
    if test:
        data = [-8888.8, 234.5, 546.9, 1, 2, 3]
    else:
        eleName = str(eleName)
        if os.path.exists(datafile):
            orgdata = loadfn(datafile)
            if eleName in orgdata:
                data = orgdata[eleName]
            else:
                data = []
        else:
            data = []
    return data

def select_mode(mode="shang"):
    '''
    Selection of the mode

    Parameter
        mode: string
            The mode of the period table
                full: full period table
                shang: Computational Materials Science 48 (2010) 813–826
    Return
        nrow: int
            The number of rows of the table
        ncol: int
            The number of column of the table
        emptyInd: list[int]
            The index of the empty subplot
        eleOrd: list[int]
            The list of the element order shown int the table (from left to right, from top to bottom)
    '''
    Ind = list(range(0, 119))
    if mode == "shang":
        nrow = 7
        ncol = 17
        emptyInd = {0: list(range(2, 12)), 1: list(range(2, 12)), 4: [2], 
                    5: [0, 1]}
        Ind = list(range(0, 104))
        eleOrd = Ind[3:10] + Ind[11:18] + Ind[19:36] + Ind[37:54] + \
                 Ind[55:57] + Ind[72:86] + Ind[57:72] + Ind[87:104]
    elif mode == "full":
        nrow = 9
        ncol = 18
        #emptyInd = {0: list(range(1, 17)), 1: list(range(2, 12)), 2: list(range(2, 12)),
        #            7: list(range(0, 18)), 8: [0, 1, 16, 17], 9: [0, 1, 16, 17]}
        emptyInd = {0: list(range(1, 17)), 1: list(range(2, 12)), 2: list(range(2, 12)),
                    7: [0, 1, 2, 17], 8: [0, 1, 2, 17]}
        eleOrd = Ind[1:58] + Ind[72:90] + Ind[104:119] + Ind[58:72] + Ind[90:104]
    return nrow, ncol, emptyInd, eleOrd


mode="full"
test_flag = True
n_txt = 6
datafile = "bcc-cijk.json"
savefilename = "periodTablePlot_test.png"

nrow, ncol, emptyInd, eleOrd = select_mode(mode)

bkcolor = '0.9'  #gray
fontsize = 12

k = 1.5   #The factor for the head (position)
kfont = 1.2     # The factor for the head (font)
fig_height = 1.5 * float(fontsize * n_txt + int(kfont*fontsize)) / float(72) * float(nrow)
fig_width = float(ncol)

fig, axs = plt.subplots(nrow, ncol, figsize=(fig_width, fig_height), sharex=True, sharey=True)
fig.tight_layout()
width = 1./float(ncol)
height = 1./float(nrow)
i_ele = 0
for i in range(0, len(axs)):
    bottom = 1. - float(i)/float(nrow)
    for j in range(len(axs[0])):
        left = float(j)/float(ncol)
        pos = [left, bottom, width, height]
        axij = axs[i][j]
        #if i == notepos[0] and j == notepos[1]:
        #    axij.remove()
        #    set_content(axij, text=notetext, head="element", fontsize=fontsize-1, kfont=kfont, k=k)
        if (i in emptyInd) and (j in emptyInd[i]):
            axij.remove()
        else:
            i_ele += 1
            eleName = get_eleName(i_ele, eleOrd)
            test_text = get_text(eleName, datafile=datafile, test=test_flag)
            set_content(axij, textlist=test_text, head=eleName, n_txt=n_txt, fontsize=fontsize, kfont=kfont, k=k, bkcolor=bkcolor)
#fig.suptitle('Periodic Table')
plt.subplots_adjust(wspace =0, hspace =0)
plt.savefig(savefilename, dpi=150)
