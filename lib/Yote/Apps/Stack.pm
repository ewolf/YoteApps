package Yote::Apps::Stack;

#
# The Stack App is a simple productivity tool where the user ads tasks, complete tasks and gets a random task.
# The idea is that one will shuffle random tasks until a task that can be done right now will appear.
# The user will see :
#    a text field and button for adding a new task
#    the current task at hand
#    a button to complete the task at hand
#    a button to set the task at hand to a random task.
#

use strict;

use base 'Yote::AppRoot';

use Yote::Obj;

use vars qw($VERSION);
$VERSION = '0.01';

#
# This sets up the account object for Stack the very first time a person logs into Stack.
# A single person login will have a separate account for each different Yote App.
#
sub _init_account {
    my( $self, $account ) = @_;
    $account->add_to_stack( 'start adding tasks' );
} #_init_account

#
# Ads a task to the list of tasks.
#
sub add_task {
    my( $self, $data, $acct ) = @_;
    $acct->add_to_stack( $data );
    $acct->get_current_task( $data ); # if empty, the current task will be set to this one.
}

#
# Returns the task object that is marked as current.
#
sub current_task {
    my( $self, $data, $acct ) = @_;
    return $acct->get_current_task();
}

#
# Changes the current task to a random one from the list and returns the one chosen.
#
sub random_task {
    my( $self, $data, $acct ) = @_;
    my $stack = $acct->get_stack();
    if( @$stack > 1 ) {
	my $current_task = $self->get_current_task();
	my $task = $current_task;
	while( $current_task->_is( $task ) ) { # exclude the current task from the task selection
	    $task = $stack->[ int( rand( @$stack ) ) ];
	}
	$acct->set_current_task( $task );
	return $task;
    } else {
	return $acct-get_current_task();
    }
} #random_task

#
# Mark the task that is marked current as completed.
#
sub complete_current_task {
    my( $self, $data, $acct ) = @_;
    $acct->remove_from_stack( $self->get_current_task() );
    $self->random_task( $data, $acct );
} #complete_task

1;
