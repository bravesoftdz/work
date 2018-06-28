(*
UCRPEDEF.INC
Crystal Reports VCL Component - Compiler Directives & Conditional Defines
Copyright(c) 2003 Crystal Decisions Inc.
*)

{******************************************************************************}
{  Compiler Directives                                                         }
{******************************************************************************}
{=== Code Generation Directives ===}
{$A-}   {Align Fields off: required to get proper values from
         PEGetJobStatus, PEExportOptions, etc.}
{$W-}   {StackFrames off: only for Win 3.0, not required}
{$U-}   {Pentium-Safe FDIV off}

{$O+}   {Optimizations on}

{=== Runtime Error Checking ===}
{$S+}   {Stack Checking on: for Stack overflows}
{$I+}   {I/O Checking on}
{$Q-}   {Overflow Checking off}
{$IFOPT D+}
  {$R+} {Range-Checking on: for development debugging}
{$ELSE}
  {$R-} {Range-Checking off: for distribution}
{$ENDIF}

{=== Syntax Options ===}
{$B-}   {Complete Boolean Evaluation off}
{$X+}   {Extended Syntax on: for Pchar types, etc.}
{$H+}   {Huge Strings on}
{$V-}   {Strict Var Strings off}
{$P+}   {Open Parameters on}


