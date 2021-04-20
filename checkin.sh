#!/usr/bin/env bash
# =============================================================================
# $Id: checkin.sh 0.7 2021/04/20 12:13:20 [dlcrites on dlim] Exp $
# =============================================================================
readonly lzero=$(readlink -f $0)
readonly bzero=$(basename $lzero .sh)
readonly dzero=$(dirname $lzero)
readonly now=$(date '+%d-%b-%Y, %H:%M:%S')
readonly tstamp=$(date '+%Y%m%d.%H%M%S')
# $Id: checkin.sh 0.7 2021/04/20 12:13:20 [dlcrites on dlim] Exp $
# ===============================================
# NOTE: This script should be in the same subdirectory as the .git directory.
cd $dzero
# =============================================================================

# =============================================================================
# Set up the dot directory (./.checkin) for other potential scripts.
# ./.checkin/do-before.sh -- Whatever you want run before the checkin.sh
#    process is executed.
# ./.checkin/do-after.sh -- Whatever you want run after the checkin.sh process
#    is executed.
# ./.checkin/do-instead.sh -- Code to run INSTEAD of the checkin process
#    defined in here.
# ===============================================
if [[ ! -d ./.$bzero ]] ; then mkdir -pm 0755 ./.$bzero ; fi
for f in do-before.sh do-after.sh ; do
    if [[ ! -f ./.$bzero/$f ]] ; then
        # Push something to each of the scripts for the user to build upon.
        head -15 ./$bzero.sh 1>./.$bzero/$f
        chmod 0755 ./.$bzero/$f
        fi
    done
# =============================================================================

# =============================================================================
# Run the do-before.sh script.
# ===============================================
( ./.$bzero/do-before.sh 2>&1 ) 1>>/tmp/$bzero.$tstamp.rpt
# =============================================================================

# =============================================================================
# Check this in.
# ===============================================
project=$(dirname $dzero)     # Assumes the directory name is the project name.
who=$(whoami|awk '{print $1}') # Assumes the one running this made the changes.
usrmsg="$*"          # Allows the one running this to add something to the log.
# ===============================================
msg="Automagic processing of $project by $who.\n"
if [[ "Z$usrmsg" == "Z" ]] ; then
    msg="${msg}Using $bzero at $now."
else
    msg="${msg}${usrmsg}\n"
    msg="${msg}Using $bzero at $now."
fi
# ===============================================
(
echo "Checking in with this message: $msg"

if [[ -x ./.$bzero/do-instead.sh ]] ; then
    ./.$bzero/do-instead.sh 2>&1
else
    git add . && git commit -m "$msg" && git push
fi
) 1>>/tmp/$bzero.$tstamp.rpt 2>&1
# =============================================================================

# =============================================================================
# Run the do-after.sh script.
# ===============================================
( ./.$bzero/do-after.sh 2>&1 ) 1>>/tmp/$bzero.$tstamp.rpt
# =============================================================================

# =============================================================================
cat /tmp/$bzero.$tstamp.rpt
# =============================================================================
