package SMS::MessageBird::API::HLR;

use strict;
use warnings;

use parent 'SMS::MessageBird::API';

sub send {
    my ($self, %params) = @_;

    return $self->_api_request(
        post => "/hlr",
        \%params,
    );
}

sub get {
    my ($self, $hlr_id) = @_;

    my $route = ($hlr_id) ? "/hlr/$hlr_id"
                          : '/hlr';

    return $self->_api_request( get => $route );
}

sub remove {
    my ($self, $hlr_id) = @_;

    return $self->_no_param_supplied('HLR ID') if !$hlr_id;

    return $self->_api_request( delete => "/hlr/$hlr_id" );
}

sub del {
    my ($self, $hlr_id) = @_;

    return $self->remove($hlr_id);
}

1;

