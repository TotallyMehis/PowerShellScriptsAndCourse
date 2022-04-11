# Use Get-Job to list all running workflows if running it with -AsJob
#
# Uses WWF (Windows Workflow Foundation)
# Gets converted into XAML.
# Saves checkpoints in case workflow is interrupted. Checkpoints are created at the start and end by default.
#

# Run with -PSComputerName <names> to deploy it on a specific computer.
Workflow Test-WorkflowTest1 {
    Param (
        $Param1
    )

    $a = 0
    
    # Will create a checkpoint and save variable 'a' and 'Param1'
    # In case the execution stops here.
    #Checkpoint-Workflow
    
    Parallel {
        # Parallel-block runs these commands
        # simultaneously. Well, at least it should.
        #Write-Output "Test: $a"
        #Write-Output "Test 2: $a"
    }
    Sequence {
        # Sequence-block runs all these 
        # Looks like only useful inside a parallel-block.
    }

    # Run these in simultaneously. Can be throttled (limited).
    #Foreach -parallel ($item in $collection) {
    #    
    #}

    # Switch can only be used with -CaseSensitive switch
    # Switch -CaseSensitive ($a) {
    #     0 {}
    #     1 {}
    # }

    Write-Output $a
}
