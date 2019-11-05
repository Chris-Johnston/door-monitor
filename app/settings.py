from flask import request, Blueprint, jsonify, render_template, redirect
from database import get_db

settings_page = Blueprint("settings_page", __name__)


@settings_page.route("/settings/webhooks")
def webhooks_settings():
    """
    Shows the settings page
    """
    with get_db() as DB:
        c = DB.cursor()
        results = c.execute(
            """
            SELECT
            id,
            type,
            endpointUrl,
            authorizationHeader,
            enabled
            FROM webhooks
            ORDER BY id;
            """
        )

        webhooks = []
        for result in results:
            webhooks.append(
                {
                    "webhook_id": result[0],
                    "webhook_type": result[1],
                    "endpoint_url": result[2],
                    "endpoint_secret": result[2][0:15] + '*' * (len(result[2]) - 15),
                    "authorization_header": result[3],
                    "authorization_secret": result[3][0:10] + '*' * (len(result[3]) - 10),
                    "enabled": result[4],
                    # "timestamp": result[5]
                }
            )
    return render_template("webhooks.html", webhooks = webhooks)

@settings_page.route("/settings/webhooks/<int:webhook_id>")
def edit_settings(webhook_id: int):
    """
    Shows the edit page
    """
    with get_db() as DB:
        c = DB.cursor()
        c.execute(
            """
            SELECT
            id,
            type,
            endpointUrl,
            authorizationHeader,
            enabled
            FROM webhooks
            ORDER BY id
            """
        )

        result = c.fetchone()
    if result is None:
        return "Not found", 404
    webhook = {
        "webhook_id": result[0],
        "webhook_type": result[1],
        "endpoint_url": result[2],
        "endpoint_secret": result[2][0:15] + '*' * (len(result[2]) - 15),
        "authorization_header": result[3],
        "authorization_secret": result[3][0:10] + '*' * (len(result[3]) - 10),
        "enabled": result[4],
        # "timestamp": result[5]
    }
    title = f"Edit Webhook #{result[0]}"
    action = f"/api/webhook/{result[0]}"
    return render_template("edit_webhook.html", webhook = webhook, title = title, action = action)

@settings_page.route("/settings/webhooks/new")
def create_webhook():
    """
    Shows the new page
    """
    webhook = {
        "webhook_id": None,
        "webhook_type": "",
        "endpoint_url": "",
        "endpoint_secret": "",
        "authorization_header": "",
        "authorization_secret": "",
        "enabled": 1
    }
    title = f"Create New Webhook"
    action = f"/api/webhook"
    return render_template("edit_webhook.html", webhook = webhook, title = title, action = action)

@settings_page.route("/api/webhook/<int:webhook_id>", methods = [ "POST" ])
def api_update(webhook_id: int):
    with get_db() as DB:
        c = DB.cursor()
        c.execute(
            """
            UPDATE webhooks SET
            type = ?,
            endpointUrl = ?,
            authorizationHeader = ?,
            enabled = ?,
            timestamp = date('now')
            WHERE id == ?;
            """,
            (
                request.form["type"],
                request.form["endpoint_url"],
                request.form["authorization_header"],
                0 if "enabled" not in request.form else request.form["enabled"],
                webhook_id
            )
        )
        DB.commit()
    return redirect("/settings/webhooks")

@settings_page.route("/api/webhook", methods = [ "POST" ])
def api_create():
    with get_db() as DB:
        c = DB.cursor()
        c.execute(
            """
            INSERT INTO webhooks
            (type, endpointUrl, authorizationHeader, enabled)
            VALUES
            (?, ?, ?, ?);
            """,
            (
                request.form["type"],
                request.form["endpoint_url"],
                request.form["authorization_header"],
                0 if "enabled" not in request.form else request.form["enabled"]
            )
        )
        DB.commit()
    return redirect("/settings/webhooks")

