package SMS::MessageBird::API::Verify;

use strict;
use warnings;

use parent 'SMS::MessageBird::API';

sub send {
    my ($self, %params) = @_;

    return $self->_no_param_supplied('recipient') if !exists $params{recipient};

    return $self->_api_request(
        post => "/verify",
        \%params,
    );
}

sub verify {
    my ($self, $verify_id) = @_;

    return $self->_no_param_supplied('verify_id') if !$verify_id;

    return $self->_api_request( get => "/verify/$verify_id" );
}

sub get {
    my ($self, $verify_id) = @_;

    return $self->verify($verify_id);
}

sub remove {
    my ($self, $verify_id) = @_;

    return $self->_no_param_supplied('verify ID') if !$verify_id;

    return $self->_api_request( delete => "/verify/$verify_id" );
}

sub del {
    my ($self, $verify_id) = @_;

    return $self->remove($verify_id);
}

1;

