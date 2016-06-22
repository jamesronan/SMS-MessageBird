package SMS::MessageBird::API::Balance;

use strict;
use warnings;

use parent 'SMS::MessageBird::API';


sub get {
    my ($self) = @_;

    return $self->_api_request( get => '/balance' );
}


1;

