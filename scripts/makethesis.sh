latex thesis.tex
bibtex thesis
latex thesis.tex
latex thesis.tex
# if your thesis is shifted vertically, try -ta4 or -tb5
dvips thesis.dvi
# generate high resolution pdf for printing
ps2pdf \
-dMaxSubsetPct=100 -dCompatibilityLevel=1.3 \
-dSubsetFonts=true -dEmbedAllFonts=true \
-dAutoFilterColorImages=false \
-dAutoFilterGrayImages=false \
-dColorImageFilter=/FlateEncode \
-dGrayImageFilter=/FlateEncode \
-dMonoImageFilter=/FlateEncode \
thesis.ps thesis.pdf
# uncomment for low resolution pdf (faster)
#ps2pdf thesis.ps temp_thesis.pdf
#  Cleanup latex temporary files
rm -f *.aux *.dvi *.log *.ps *.blg *.bbl *.toc *.out chapter?/*.aux

