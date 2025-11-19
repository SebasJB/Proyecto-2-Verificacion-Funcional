simSetSimulator "-vcssv" -exec "./salida" -args "+UVM_TIMEOUT=32000" -uvmDebug on \
           -simDelim
debImport "-i" "-simflow" "-dbdir" "./salida.daidir"
srcTBInvokeSim
srcHBSelect "tb_top" -win $_nTrace1
srcSetScope "tb_top" -delim "." -win $_nTrace1
srcHBSelect "tb_top" -win $_nTrace1
srcSetScope "tb_top" -delim "." -win $_nTrace1
srcHBSelect "tb_top.term_if\[0\]" -win $_nTrace1
srcSetScope "tb_top.term_if\[0\]" -delim "." -win $_nTrace1
srcHBSelect "tb_top.term_if\[0\]" -win $_nTrace1
srcSignalViewSelect "tb_top.term_if\[0\].data_in\[39:0\]"
srcSignalViewSelect "tb_top.term_if\[0\].data_in\[39:0\]" \
           "tb_top.term_if\[0\].popin"
srcSignalViewSelect "tb_top.term_if\[0\].data_out\[39:0\]"
srcSignalViewSelect "tb_top.term_if\[0\].data_in\[39:0\]"
srcSignalViewSelect "tb_top.term_if\[0\].data_in\[39:0\]" \
           "tb_top.term_if\[0\].popin"
srcSignalViewSelect "tb_top.term_if\[0\].data_in\[39:0\]" \
           "tb_top.term_if\[0\].popin" "tb_top.term_if\[0\].data_out\[39:0\]"
srcSignalViewSelect "tb_top.term_if\[0\].data_in\[39:0\]" \
           "tb_top.term_if\[0\].popin" "tb_top.term_if\[0\].data_out\[39:0\]" \
           "tb_top.term_if\[0\].pop"
srcSignalViewSelect "tb_top.term_if\[0\].data_in\[39:0\]" \
           "tb_top.term_if\[0\].popin" "tb_top.term_if\[0\].data_out\[39:0\]" \
           "tb_top.term_if\[0\].pop" "tb_top.term_if\[0\].pndng"
wvCreateWindow
srcSignalViewAddSelectedToWave -win $_nTrace1 -clipboard
wvDrop -win $_nWave3
srcTBRunSim
wvZoomIn -win $_nWave3
wvZoomIn -win $_nWave3
wvScrollDown -win $_nWave3 0
wvZoomIn -win $_nWave3
wvZoomIn -win $_nWave3
wvSetCursor -win $_nWave3 22714.834890 -snap {("G1" 4)}
wvSetCursor -win $_nWave3 22724.915535 -snap {("G1" 4)}
wvSetCursor -win $_nWave3 22714.834890 -snap {("G1" 4)}
wvSetCursor -win $_nWave3 22714.834890 -snap {("G1" 4)}
wvSetCursor -win $_nWave3 22724.862732 -snap {("G1" 4)}
wvZoomIn -win $_nWave3
wvZoomIn -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3
wvScrollDown -win $_nWave3 2
wvZoomIn -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomIn -win $_nWave3
wvZoomIn -win $_nWave3
wvZoomIn -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomIn -win $_nWave3
wvScrollDown -win $_nWave3 0
wvScrollDown -win $_nWave3 0
wvScrollDown -win $_nWave3 0
wvScrollDown -win $_nWave3 0
wvScrollDown -win $_nWave3 0
wvScrollDown -win $_nWave3 0
wvScrollDown -win $_nWave3 0
wvScrollDown -win $_nWave3 0
wvScrollDown -win $_nWave3 0
wvScrollUp -win $_nWave3 1
wvScrollDown -win $_nWave3 0
wvScrollDown -win $_nWave3 0
wvScrollDown -win $_nWave3 0
wvScrollDown -win $_nWave3 0
wvScrollDown -win $_nWave3 0
wvScrollDown -win $_nWave3 0
wvScrollUp -win $_nWave3 1
wvZoomIn -win $_nWave3
wvZoomIn -win $_nWave3
wvZoomIn -win $_nWave3
debExit
