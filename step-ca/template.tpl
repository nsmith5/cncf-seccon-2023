{
    "subject": "",
    "keyUsage": ["digitalSignature"],
    "extKeyUsage": ["codeSigning"],
    "sans": [{
        "type": "uri",
        "value": {{ toJson .Token.Sub }}
    }]
}
