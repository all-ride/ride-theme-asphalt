<p>Hello {$user->getDisplayName()},</p>

<p>You have registered a new email address. Please confirm this address through the link below:<br />
{url id="profile.email.confirm" parameters=["user" => $encryptedUsername, "email" => $encryptedEmail] var="url"}
<a href="{$url}">{$url}</a>
</p>
