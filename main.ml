#mod_use "while_ast.ml";;
#mod_use "while_parser.ml";;
#mod_use "while_lexer.ml";;
#mod_use "data_flow.ml";;
#mod_use "lv_analysis.ml";;

open Data_flow;;
open Lv_analysis;;

let main argv argc =
  let input_file = open_in "examples/example.while" in
  let lexer_buffer = Lexing.from_channel input_file in
  let ast = While_parser.prog While_lexer.read lexer_buffer in 
  let (dfg, max_lab) = build_data_flow_graph ast in
  let idfg = inverse_data_flow_graph dfg max_lab in
  (idfg, final_set dfg max_lab);;
