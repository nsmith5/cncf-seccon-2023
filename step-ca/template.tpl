{
    "subject": {{ toJson .Token.sub }},
    "keyUsage": ["digitalSignature"],
    "extKeyUsage": ["codeSigning"],
    "sans": [{
        "type": "uri",
        "value": "https://github.com/{{ .Token.workflow_ref }}"
    }],
    "extensions": [
        { "id": "1.3.6.1.4.1.57264.1.1", "critical": false, "value": "{{ b64enc .Token.iss }}" },
        { "id": "1.3.6.1.4.1.57264.1.2", "critical": false, "value": "{{ b64enc .Token.event_name }}" },
        { "id": "1.3.6.1.4.1.57264.1.3", "critical": false, "value": "{{ b64enc .Token.sha }}" }
    ]
}
