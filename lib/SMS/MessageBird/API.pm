package SMS::MessageBird::API;

use strict;
use warnings;

use LWP::UserAgent;
use JSON;

=head1 NAME

SMS::MessageBird::API - Provides API interation base for SMS::MessageBird.

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';

=head1 METHODS

=head2 new (contructor)

Creates a new instance of SMS::MessageBird. It requires the MessageBird API
key.

=cut

sub new {
    my ($package, %params) = @_;

    if (!%params || !exists $params{api_key} || !$params{api_key}) {
        warn 'No API key suppied to SMS::MessageBird contructor';
        return undef;
    }

    my $self = bless {
        api_key => $params{api_key},
    } => ($package || 'SMS::MessageBird');

    $self->{originator} = $params{originator} if $params{originator};

    $self->{api_url}
        = $params{api_url} || 'https://rest.messagebird.com';

    $self->{ua} = LWP::UserAgent->new(
        agent           => "Perl/SMS::MessageBird/$VERSION",
        default_headers => HTTP::Headers->new(
            'content-type' => 'application/json',
            Accept         => 'application/json',
            Authorization  => 'AccessKey ' . $self->{api_key},
        ),
    );

    return $self;
}

=head2 originator

 In: $originator (optional) - New originator to set.
 Out: The currently set originator.

Mutator for the originator parameter. This parameter is the displayed
"From" in the SMS. It can be a phone number (including country code) or an
alphanumeric string of up to 11 characters.

This can be set for the lifetime of the object and used for all messages sent
using the instance or passed individually to each call.

You can pass the originator param to the constructor rather than use this
mutator, but it's here in case you want to send 2 batches of SMS from differing
originiators using the same object.

=cut

sub originator {
    my ($self, $originator) = @_;

    $self->{originator} = $originator if $originator;

    return $self->{originator};
}


sub _api_request {
    my ($self, $method, $endpoint, $data) = @_;

    my %request_params;
    if ($data) {
        my $content_payload = JSON->new->encode($data);

        $request_params{'Content-Type'} = 'application/json',
        $request_params{Content} = $content_payload;
    }

    my $api_response = $self->{ua}->$method(
        $self->_full_endpoint($endpoint),
        %request_params,
    );

    return {
        ok      => ($api_response->is_success) ? 1 : 0,
        code    => $api_response->code,
        content => JSON->new->pretty(1)->decode($api_response->content),
    };
}

sub _full_endpoint {
    my ($self, $endpoint) = @_;

    return $self->{api_url} . $endpoint;
}

sub _no_param_supplied {
    my ($self, $param) = @_;

    return {
        http_code => undef,
        ok        => 0,
        content   => {
            errors => [
                { description => "No $param supplied" }
            ],
        },
    };
}

1;

