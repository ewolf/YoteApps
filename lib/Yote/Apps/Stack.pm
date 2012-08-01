package Yote::Apps::Stack;

#
# The Stack App is a simple productivity tool where the user ads tasks, complete tasks and gets a random task.
# The idea is that one will shuffle random tasks until a task that can be done right now will appear.
#
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

sub add_task {
    my( $self, $data, $acct ) = @_;
    $acct->add_to_stack( $data );
    $acct->get_current_task( $data ); # if empty, the current task will be set to this one.
}

sub current_task {
    my( $self, $data, $acct ) = @_;
    return $acct->get_current_task();
}

sub random_task {
    my( $self, $data, $acct ) = @_;
    my $stack = $acct->get_stack();
    my $task = $stack->[ int( rand( @$stack ) ) ];
    $acct->set_current_task( $task );
    return $task;
} #random_task

sub complete_current_task {
    my( $self, $data, $acct ) = @_;
    $acct->remove_from_stack( $self->get_current_task() );
    $self->random_task( $data, $acct );
} #complete_task

1;
