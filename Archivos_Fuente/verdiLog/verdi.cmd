simSetSimulator "-vcssv" -exec "./salida" -args "+UVM_TIMEOUT=30000" -uvmDebug on \
           -simDelim
debImport "-i" "-simflow" "-dbdir" "./salida.daidir"
srcTBInvokeSim
srcHBSelect "tb_top.term_if\[0\]" -win $_nTrace1
srcSetScope "tb_top.term_if\[0\]" -delim "." -win $_nTrace1
srcHBSelect "tb_top.term_if\[0\]" -win $_nTrace1
srcSignalViewSelect "tb_top.term_if\[0\].data_in\[39:0\]"
srcSignalViewSelect "tb_top.term_if\[0\].clk"
srcSignalViewSelect "tb_top.term_if\[0\].data_in\[39:0\]"
srcSignalViewSelect "tb_top.term_if\[0\].data_in\[39:0\]" \
           "tb_top.term_if\[0\].pndng_in" "tb_top.term_if\[0\].popin" \
           "tb_top.term_if\[0\].data_out\[39:0\]" "tb_top.term_if\[0\].pop" \
           "tb_top.term_if\[0\].pndng"
srcSignalViewSelect "tb_top.term_if\[0\].data_in\[39:0\]" \
           "tb_top.term_if\[0\].pndng_in" "tb_top.term_if\[0\].popin" \
           "tb_top.term_if\[0\].data_out\[39:0\]" "tb_top.term_if\[0\].pop" \
           "tb_top.term_if\[0\].pndng" "tb_top.term_if\[0\].clk"
wvCreateWindow
srcSignalViewAddSelectedToWave -win $_nTrace1 -clipboard
wvDrop -win $_nWave3
srcTBRunSim
srcHBSelect "tb_top.CFG\[13\]" -win $_nTrace1
srcHBSelect "tb_top.term_if\[0\]" -win $_nTrace1
srcSetScope "tb_top.term_if\[0\]" -delim "." -win $_nTrace1
srcHBSelect "tb_top.term_if\[0\]" -win $_nTrace1
srcSignalViewSelect "tb_top.term_if\[0\].reset"
wvSetPosition -win $_nWave3 {("G2" 0)}
wvSetPosition -win $_nWave3 {("G1" 7)}
wvAddSignal -win $_nWave3 "/tb_top/term_if\[0\]/reset"
wvSetPosition -win $_nWave3 {("G1" 7)}
wvSetPosition -win $_nWave3 {("G1" 8)}
wvSetCursor -win $_nWave3 97.751711 -snap {("G2" 0)}
debExit
