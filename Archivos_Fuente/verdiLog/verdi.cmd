simSetSimulator "-vcssv" -exec "./salida" -args "+UVM_TIMEOUT=38000" -uvmDebug on \
           -simDelim
debImport "-i" "-simflow" "-dbdir" "./salida.daidir"
srcTBInvokeSim
srcHBSelect "tb_top.term_if\[3\]" -win $_nTrace1
srcSetScope "tb_top.term_if\[3\]" -delim "." -win $_nTrace1
srcHBSelect "tb_top.term_if\[3\]" -win $_nTrace1
srcSignalViewSelect "tb_top.term_if\[3\].clk"
srcSignalViewSelect "tb_top.term_if\[3\].clk" \
           "tb_top.term_if\[3\].data_out\[39:0\]"
srcSignalViewSelect "tb_top.term_if\[3\].clk" \
           "tb_top.term_if\[3\].data_out\[39:0\]" "tb_top.term_if\[3\].pop"
srcSignalViewSelect "tb_top.term_if\[3\].clk" \
           "tb_top.term_if\[3\].data_out\[39:0\]" "tb_top.term_if\[3\].pop" \
           "tb_top.term_if\[3\].pndng"
wvCreateWindow
srcSignalViewAddSelectedToWave -win $_nTrace1 -clipboard
wvDrop -win $_nWave3
srcTBRunSim
wvZoomIn -win $_nWave3
wvZoomIn -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3
wvSetCursor -win $_nWave3 36002.754545 -snap {("G1" 1)}
wvZoomIn -win $_nWave3
wvZoomIn -win $_nWave3
wvSetCursor -win $_nWave3 36048.369838 -snap {("G1" 3)}
wvSetCursor -win $_nWave3 36049.427797 -snap {("G1" 3)}
wvSetCursor -win $_nWave3 36050.133103
wvSetCursor -win $_nWave3 36044.490657 -snap {("G1" 1)}
debExit
