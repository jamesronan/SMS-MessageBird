package SMS::MessageBird::API::Voice;

use strict;
use warnings;

use parent 'SMS::MessageBird::API';


sub send {
    my ($self, %params) = @_;

    return $self->_api_request(
        post => '/voicemessages',
        \%params
    );
}

sub receive {
    my ($self, $voice_message_id) = @_;

    my $route = ($voice_message_id) ? "/voicemessages/$voice_message_id"
                                    : '/voicemessages';

    return $self->_api_request( get => $route );
}

sub get {
    my ($self, $voice_message_id) = @_;
    return $self->receive($voice_message_id);
}

sub remove {
    my ($self, $voice_message_id) = @_;

    return $self->_no_param_supplied('voice message ID') if !$voice_message_id;

    return $self->_api_request( delete => "/voicemessages/$voice_message_id" );
}

sub del {
    my ($self, $voice_message_id) = @_;
    return $self->remove($voice_message_id);
}


1;

