function trap_ctrlc ()
{
    exit 2
}
trap "trap_ctrlc" 2
