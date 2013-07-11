package Yote::Apps::Organizer;

#
# Complicated organizational tool. Can add 
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

