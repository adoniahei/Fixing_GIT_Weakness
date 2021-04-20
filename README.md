# Fixing_GIT_Weakness
Things I have to have in order to overcome the weaknesses in GIT.

The most profound weakness that GIT suffers from is the attitude of those who proport to be advocates for it.  Their (primary) knee-jerk response to critics is to denigrate the individual, then trivialize the criticism, and totally ignore what is being said.  So by fiat, GiT is "the one and only option" for "reasonable" people. The rest of us are browbeat into agreeing.

I resisted using GIT until I found a few workarounds for the idiocy of some of the issues.  This git repo contains the ones I can offer to the public.

pre-commit: This goes into ./.git/hooks directory. It then happens automagically -- as long as you add the Id tag. Without the Id tag, nothing in here matters.  I focused on the Id tag because many of the other tags could be extracted from it.

checkin.sh: This is an example script I use to check in all changes at once.
