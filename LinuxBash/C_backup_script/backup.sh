#!/bin/bash

# BASIC REQUIREMENTS & INFO:
# Data backup script that takes the following data as parameters:
# 1. Path to the syncing directory.
# 2. The path to the directory where the copies of the files will be stored.
# In case of adding new or deleting old files, the script must add a corresponding entry to the log file indicating the time, type of operation and file name.
# All files in syncing directory shouldn't contain spaces!

# set parameters:

SYNC_DIR=$1
BACKUP_DIR=$2
BACKUP_LOG="$(dirname "$0")/backup.log"

# functions:

function checkLogFile {
    if [ -a $BACKUP_LOG ] ; then # check is backup log exists in script directory
        echo $'\n'"The backup log exists in $(readlink -f $BACKUP_LOG)"
    else
        echo $'\n'"Created backup log in $(readlink -f $BACKUP_LOG)"
        touch $BACKUP_LOG
    fi
}

function checkBackupFolder {
    if [ -a $BACKUP_DIR ] ; then # check is backup directory exists
        echo "The backup directory is $BACKUP_DIR"
    else
        echo "Created backup directory in $BACKUP_DIR"
        mkdir $BACKUP_DIR
    fi
}

function checkNumberArgs {
    if [ $# -ne 2 ] ; then # check correct number of arguments (must be 2 exactly)
        echo $'\n'"Make sure that you run this script whith 2 parameters, where:"
        echo "FIRST patameter is a path to the syncing directory"
        echo "SECOND patameter is a path to the directory where the copies of the files will be stored"$'\n'
        exit
    else
        return 0
    fi
}

function checkAndCopyNewerFiles {
    if [ $SYNC_DIR/$file -nt $BACKUP_DIR/$file ] ; then # is file in SYNC_DIR newer?
        cp -r $SYNC_DIR/$file $BACKUP_DIR/$file # recursive copy
        echo "$(date '+%Y-%m-%d %H:%M:%S') - UPD - $file">> $BACKUP_LOG
    else
        return 0
    fi
}

function checkDeletedFiles {
    for file in $(find $BACKUP_DIR -printf "%P\n") ; do
        if [ -a $SYNC_DIR/$file ] ; then # is that file exist in SYNC_DIR?
            :
        else
            echo "$(date '+%Y-%m-%d %H:%M:%S') - DEL - $file">> $BACKUP_LOG # because file does not exist
        fi
    done
}

function performBackup {
    echo "The syncing directory is $SYNC_DIR"
    printf "CHECK STARTED at $(date '+%Y-%m-%d %H:%M:%S')"$'\n'>> $BACKUP_LOG
    for file in $(find $SYNC_DIR -printf "%P\n") ; do
        if [ -a $BACKUP_DIR/$file ] ; then # is that file exist in BACKUP_DIR?
            checkAndCopyNewerFiles
        else
            cp -r $SYNC_DIR/$file $BACKUP_DIR/$file # recursive copy
            echo "$(date '+%Y-%m-%d %H:%M:%S') - NEW - $file">> $BACKUP_LOG # because file does not exist
        fi
    done
    checkDeletedFiles
    printf $"CHECK FINISHED at $(date '+%Y-%m-%d %H:%M:%S')"$'\n'$'\n'>> $BACKUP_LOG
}

# main process:

checkNumberArgs $@ && checkLogFile && checkBackupFolder && performBackup && echo $'\n'"All operations completed successfully"$'\n' || echo "ERROR"