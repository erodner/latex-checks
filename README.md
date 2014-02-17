During writing my thesis, I wrote some scripts and extended some others to check for inconsistencies in the text or detect some common English mistakes done by German speakers. I created a git repository with all those tiny (quick'n'dirty) scripts and you can use them by 

1. cloning the git repository:
``git clone http://www.github.com/erodner/latex-checks``

2. adding the path of the scripts to your PATH variable (-> .bashrc)

3. and applying it on your latex document (runs multiple tests)
check-english-latex-document.sh <tex-document>

Some checks included in the scripts are questionable and the detection
is not perfect. However, I think it is quite useful and you are invited to extend it with your
own rules or some useful documentation :).
