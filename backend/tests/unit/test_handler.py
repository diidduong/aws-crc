import json

import pytest

from visitor_counter import app


@pytest.fixture()
def apigw_event():
    """ Generates API GW Event"""

    return {}


def test_lambda_handler(apigw_event):

    res = app.lambda_handler(apigw_event, "")

    assert res["visitorCount"] >= 0
