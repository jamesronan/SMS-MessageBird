package SMS::MessageBird::API::SMS;

use strict;
use warnings;

use parent 'SMS::MessageBird::API';

sub send {
    my ($self, %params) = @_;

    $params{originator} //= $self->{originator};

    return $self->_api_request(
        post => '/messages',
        \%params
    );
}

sub receive {
    my ($self, $message_id) = @_;

    my $route = ($message_id) ? "/messages/$message_id"
                              : '/messages';

    return $self->_api_request( get => $route );
}

sub get {
    my ($self, $message_id) = @_;
    return $self->receive($message_id);
}

sub remove {
    my ($self, $message_id) = @_;

    return $self->_no_param_supplied('message ID') if !$message_id;

    return $self->_api_request( delete => "/messages/$message_id" );
}

sub del {
    my ($self, $message_id) = @_;

    return $self->remove($message_id);
}

1;
