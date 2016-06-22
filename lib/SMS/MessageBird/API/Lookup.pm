package SMS::MessageBird::API::Lookup;

use strict;
use warnings;

use parent 'SMS::MessageBird::API';

sub get {
    my ($self, $msisdn) = @_;

    return $self->_no_param_supplied('MSISDN') if !$msisdn;

    return $self->_api_request( get => "/lookup/$msisdn" );
}

sub get_hlr {
    my ($self, $msisdn) = @_;

    return $self->_no_param_supplied('MSISDN') if !$msisdn;

    return $self->_api_request( get => "/lookup/$msisdn/hlr" );
}

sub request {
    my ($self, $msisdn) = @_;

    return $self->_no_param_supplied('MSISDN') if !$msisdn;

    return $self->_api_request( post => "/lookup/$msisdn/hlr" );
}

1;

