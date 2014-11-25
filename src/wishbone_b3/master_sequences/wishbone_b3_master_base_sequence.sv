//////////////////////////////////////////////////////////////////////////////
//  Copyright 2014 Dov Stamler (dov.stamler@gmail.com)
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//////////////////////////////////////////////////////////////////////////////

`ifndef WISHBONE_B3_MASTER_BASE_SEQUENCE__SV
`define WISHBONE_B3_MASTER_BASE_SEQUENCE__SV

// class: wishbone_b3_master_base_sequence
// Inherited to all wishbone sequence classes. This base class pulls from the config_db 
// the agents configuration object. Objections are toggled if the starting_phase
// variable is set to a non-null value by either the default sequence mechanism or manually by 
// the sequence caller. 
class wishbone_b3_master_base_sequence #(ADR_W = 32, DAT_W = 64, TAG_W = 1) extends uvm_sequence #(wishbone_b3_sequence_item #(ADR_W, DAT_W, TAG_W));
  `uvm_object_param_utils(wishbone_b3_master_base_sequence #(ADR_W, DAT_W, TAG_W))
  
  wishbone_b3_master_cfg    cfg;
  
  extern         function   new(string name = "wishbone_b3_master_base_sequence");
  extern virtual task       pre_body();
  extern virtual task       post_body();

endclass: wishbone_b3_master_base_sequence

//------------------------------------------------------------------//
function wishbone_b3_master_base_sequence::new(string name = "wishbone_b3_master_base_sequence");
  super.new(name);

endfunction: new

//------------------------------------------------------------------//
// task: pre_body
// Get the agents configuration object and raise objection if starting phase is non-null.
task wishbone_b3_master_base_sequence::pre_body();
  super.pre_body();
  
  if (starting_phase != null) starting_phase.raise_objection(this);
  
  // get the configuration object of the current agent 
  if(!uvm_config_db #(wishbone_b3_master_cfg)::get(m_sequencer, "", "cfg", cfg)) `uvm_fatal(get_type_name(), "wishbone_b3_master_cfg config_db lookup failed")

endtask: pre_body

//------------------------------------------------------------------//
// task: post_body
// Drop objection if starting phase is non-null. 
task wishbone_b3_master_base_sequence::post_body();
  super.post_body();

 if (starting_phase != null) starting_phase.drop_objection(this);
 
endtask: post_body

`endif //WISHBONE_B3_MASTER_BASE_SEQUENCE__SV
