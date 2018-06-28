#!/bin/sh

# NOTES
# 
# Reformats the MSSQL Studio object export files. 
# It removes the first three lines and changes the "CREATE" to an "ALTER"
# For example:
# 
# USE [a0000748__2014-03-09]
# GO
# /****** Object:  StoredProcedure [dbo].[sp_CashReg_WidrawCalcCash]    Script Date: 03/13/2014 12:04:22 ******/
# SET ANSI_NULLS ON
# GO
# SET QUOTED_IDENTIFIER ON
# GO
# CREATE PROCEDURE [dbo].[sp_CashReg_WidrawCalcCash]

echo 'Reformat object files.'
for file in "$@"
do
    #echo "Going to update '$file'"
    
    # Delete the first 3 lines of the file.
    sed '1,3d' "$file" > "$file.new"
    
    # Change CREATE to ALTER
    perl -pi -e 's/^CREATE (PROCEDURE)/ALTER \1/' "$file.new"
    
    mv "$file.new" "$file"
done
echo 'Done.'
