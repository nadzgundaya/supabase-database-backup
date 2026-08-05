SET session_replication_role = replica;

--
-- PostgreSQL database dump
--

-- \restrict QYBFhmgghjNqEOXWTbmQAnQlo5t3C4ok5bhhmcj5n66fjP32staidrb11u6iR2P

-- Dumped from database version 17.6
-- Dumped by pg_dump version 17.6

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Data for Name: audit_log_entries; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."audit_log_entries" ("instance_id", "id", "payload", "created_at", "ip_address") FROM stdin;
\.


--
-- Data for Name: custom_oauth_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."custom_oauth_providers" ("id", "provider_type", "identifier", "name", "client_id", "client_secret", "acceptable_client_ids", "scopes", "pkce_enabled", "attribute_mapping", "authorization_params", "enabled", "email_optional", "issuer", "discovery_url", "skip_nonce_check", "cached_discovery", "discovery_cached_at", "authorization_url", "token_url", "userinfo_url", "jwks_uri", "created_at", "updated_at", "custom_claims_allowlist") FROM stdin;
\.


--
-- Data for Name: flow_state; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."flow_state" ("id", "user_id", "auth_code", "code_challenge_method", "code_challenge", "provider_type", "provider_access_token", "provider_refresh_token", "created_at", "updated_at", "authentication_method", "auth_code_issued_at", "invite_token", "referrer", "oauth_client_state_id", "linking_target_id", "email_optional") FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."users" ("instance_id", "id", "aud", "role", "email", "encrypted_password", "email_confirmed_at", "invited_at", "confirmation_token", "confirmation_sent_at", "recovery_token", "recovery_sent_at", "email_change_token_new", "email_change", "email_change_sent_at", "last_sign_in_at", "raw_app_meta_data", "raw_user_meta_data", "is_super_admin", "created_at", "updated_at", "phone", "phone_confirmed_at", "phone_change", "phone_change_token", "phone_change_sent_at", "email_change_token_current", "email_change_confirm_status", "banned_until", "reauthentication_token", "reauthentication_sent_at", "is_sso_user", "deleted_at", "is_anonymous") FROM stdin;
\.


--
-- Data for Name: identities; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."identities" ("provider_id", "user_id", "identity_data", "provider", "last_sign_in_at", "created_at", "updated_at", "id") FROM stdin;
\.


--
-- Data for Name: instances; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."instances" ("id", "uuid", "raw_base_config", "created_at", "updated_at") FROM stdin;
\.


--
-- Data for Name: oauth_clients; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."oauth_clients" ("id", "client_secret_hash", "registration_type", "redirect_uris", "grant_types", "client_name", "client_uri", "logo_uri", "created_at", "updated_at", "deleted_at", "client_type", "token_endpoint_auth_method") FROM stdin;
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."sessions" ("id", "user_id", "created_at", "updated_at", "factor_id", "aal", "not_after", "refreshed_at", "user_agent", "ip", "tag", "oauth_client_id", "refresh_token_hmac_key", "refresh_token_counter", "scopes") FROM stdin;
\.


--
-- Data for Name: mfa_amr_claims; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."mfa_amr_claims" ("session_id", "created_at", "updated_at", "authentication_method", "id") FROM stdin;
\.


--
-- Data for Name: mfa_factors; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."mfa_factors" ("id", "user_id", "friendly_name", "factor_type", "status", "created_at", "updated_at", "secret", "phone", "last_challenged_at", "web_authn_credential", "web_authn_aaguid", "last_webauthn_challenge_data") FROM stdin;
\.


--
-- Data for Name: mfa_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."mfa_challenges" ("id", "factor_id", "created_at", "verified_at", "ip_address", "otp_code", "web_authn_session_data") FROM stdin;
\.


--
-- Data for Name: oauth_authorizations; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."oauth_authorizations" ("id", "authorization_id", "client_id", "user_id", "redirect_uri", "scope", "state", "resource", "code_challenge", "code_challenge_method", "response_type", "status", "authorization_code", "created_at", "expires_at", "approved_at", "nonce") FROM stdin;
\.


--
-- Data for Name: oauth_client_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."oauth_client_states" ("id", "provider_type", "code_verifier", "created_at") FROM stdin;
\.


--
-- Data for Name: oauth_consents; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."oauth_consents" ("id", "user_id", "client_id", "scopes", "granted_at", "revoked_at") FROM stdin;
\.


--
-- Data for Name: one_time_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."one_time_tokens" ("id", "user_id", "token_type", "token_hash", "relates_to", "created_at", "updated_at") FROM stdin;
\.


--
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."refresh_tokens" ("instance_id", "id", "token", "user_id", "revoked", "created_at", "updated_at", "parent", "session_id") FROM stdin;
\.


--
-- Data for Name: sso_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."sso_providers" ("id", "resource_id", "created_at", "updated_at", "disabled") FROM stdin;
\.


--
-- Data for Name: saml_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."saml_providers" ("id", "sso_provider_id", "entity_id", "metadata_xml", "metadata_url", "attribute_mapping", "created_at", "updated_at", "name_id_format") FROM stdin;
\.


--
-- Data for Name: saml_relay_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."saml_relay_states" ("id", "sso_provider_id", "request_id", "for_email", "redirect_to", "created_at", "updated_at", "flow_state_id") FROM stdin;
\.


--
-- Data for Name: sso_domains; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."sso_domains" ("id", "sso_provider_id", "domain", "created_at", "updated_at") FROM stdin;
\.


--
-- Data for Name: webauthn_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."webauthn_challenges" ("id", "user_id", "challenge_type", "session_data", "created_at", "expires_at") FROM stdin;
\.


--
-- Data for Name: webauthn_credentials; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."webauthn_credentials" ("id", "user_id", "credential_id", "public_key", "attestation_type", "aaguid", "sign_count", "transports", "backup_eligible", "backed_up", "friendly_name", "created_at", "updated_at", "last_used_at") FROM stdin;
\.


--
-- Data for Name: role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."role" ("slug", "displayName", "description", "roleType", "systemRole", "createdAt", "updatedAt") FROM stdin;
global:chatUser	Chat User	Can only use workflows through the chat interface, not build them	global	t	2026-07-25 07:45:51.969+00	2026-07-25 07:45:51.969+00
global:owner	Owner	Owner	global	t	2026-07-25 07:45:42.862+00	2026-07-25 07:45:52.966+00
global:admin	Admin	Full control of the instance, including all workflows and credentials	global	t	2026-07-25 07:45:42.862+00	2026-07-25 07:45:52.966+00
global:member	Member	Can create and use their own workflows and credentials	global	t	2026-07-25 07:45:42.862+00	2026-07-25 07:45:52.966+00
project:admin	Project Admin	Full control of settings, members, workflows, credentials and executions	project	t	2026-07-25 07:45:42.862+00	2026-07-25 07:45:53.862+00
project:personalOwner	Project Owner	Project Owner	project	t	2026-07-25 07:45:42.862+00	2026-07-25 07:45:53.862+00
project:editor	Project Editor	Create, edit, and delete workflows, credentials, and executions	project	t	2026-07-25 07:45:42.862+00	2026-07-25 07:45:53.862+00
project:viewer	Project Viewer	Read-only access to workflows, credentials, and executions	project	t	2026-07-25 07:45:42.862+00	2026-07-25 07:45:53.862+00
project:chatUser	Project Chat User	Chat-only access to chatting with workflows that have n8n Chat enabled	project	t	2026-07-25 07:45:42.862+00	2026-07-25 07:45:53.862+00
credential:owner	Credential Owner	Credential Owner	credential	t	2026-07-25 07:45:51.969+00	2026-07-25 07:45:51.969+00
credential:user	Credential User	Credential User	credential	t	2026-07-25 07:45:51.969+00	2026-07-25 07:45:51.969+00
workflow:owner	Workflow Owner	Workflow Owner	workflow	t	2026-07-25 07:45:51.969+00	2026-07-25 07:45:51.969+00
workflow:editor	Workflow Editor	Workflow Editor	workflow	t	2026-07-25 07:45:51.969+00	2026-07-25 07:45:51.969+00
secretsProviderConnection:owner	Secrets Provider Connection Owner	Full control of secrets provider connection settings and secrets	secretsProviderConnection	t	2026-07-25 07:45:51.969+00	2026-07-25 07:45:51.969+00
secretsProviderConnection:user	Secrets Provider Connection User	Read-only access to use secrets from the connection	secretsProviderConnection	t	2026-07-25 07:45:51.969+00	2026-07-25 07:45:51.969+00
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."user" ("id", "email", "firstName", "lastName", "password", "personalizationAnswers", "createdAt", "updatedAt", "settings", "disabled", "mfaEnabled", "mfaSecret", "mfaRecoveryCodes", "lastActiveAt", "roleSlug") FROM stdin;
d661e0bc-24f7-4347-a9ad-ba60de14eecb	naagundaya@gmail.com	Nadz	Gundaya	$2a$10$uWMuVIZ21pSFlnn02Y0E7ezX9ZJlCsBBHepsEEvvSdExbx5Ch1RX.	{"version":"v4","personalization_survey_submitted_at":"2026-07-25T07:57:29.774Z","personalization_survey_n8n_version":"2.31.6","companyType":"personal","reportedSource":"other","reportedSourceOther":"Tiktok"}	2026-07-25 07:45:36.942+00	2026-07-27 05:43:30.477+00	{"userActivated":true,"firstSuccessfulWorkflowId":"1AzpEC2wr7qj2qDP","userActivatedAt":1784973641965}	f	f	\N	\N	2026-07-27	global:owner
\.


--
-- Data for Name: project; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."project" ("id", "name", "type", "createdAt", "updatedAt", "icon", "description", "creatorId", "customTelemetryTags") FROM stdin;
mZfC7A4PSYI9o6Vm	Nadz Gundaya <naagundaya@gmail.com>	personal	2026-07-25 07:45:39.025+00	2026-07-25 07:56:39.811+00	\N	\N	d661e0bc-24f7-4347-a9ad-ba60de14eecb	[]
\.


--
-- Data for Name: agents; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."agents" ("id", "name", "projectId", "integrations", "schema", "tools", "skills", "versionId", "createdAt", "updatedAt", "activeVersionId") FROM stdin;
\.


--
-- Data for Name: agent_chat_subscriptions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."agent_chat_subscriptions" ("agentId", "integrationType", "credentialId", "threadId", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: agent_checkpoints; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."agent_checkpoints" ("runId", "agentId", "state", "expired", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: agent_history; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."agent_history" ("versionId", "agentId", "schema", "tools", "skills", "publishedById", "author", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: agent_execution_threads; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."agent_execution_threads" ("id", "agentId", "agentName", "projectId", "sessionNumber", "totalPromptTokens", "totalCompletionTokens", "totalCost", "totalDuration", "title", "emoji", "createdAt", "updatedAt", "taskId", "taskVersionId", "parentThreadId", "parentAgentId") FROM stdin;
\.


--
-- Data for Name: agent_execution; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."agent_execution" ("id", "threadId", "status", "startedAt", "stoppedAt", "duration", "userMessage", "model", "promptTokens", "completionTokens", "totalTokens", "cost", "timeline", "error", "hitlStatus", "source", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: agent_files; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."agent_files" ("id", "agentId", "binaryDataId", "fileName", "mimeType", "fileSizeBytes", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: agent_task_definition; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."agent_task_definition" ("id", "agentId", "name", "objective", "cronExpression", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: agent_task_run_lock; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."agent_task_run_lock" ("agentId", "taskId", "holderId", "heldUntil", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: agent_task_snapshot; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."agent_task_snapshot" ("versionId", "taskId", "enabled", "name", "objective", "cronExpression", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: agents_resources; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."agents_resources" ("id", "metadata", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: agents_memory_entries; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."agents_memory_entries" ("id", "agentId", "resourceId", "content", "contentHash", "status", "supersededBy", "embeddingModel", "embedding", "metadata", "lastSeenAt", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: agents_threads; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."agents_threads" ("id", "resourceId", "title", "metadata", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: agents_memory_entry_cursors; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."agents_memory_entry_cursors" ("agentId", "observationScopeId", "lastIndexedObservationId", "lastIndexedObservationCreatedAt", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: agents_memory_entry_locks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."agents_memory_entry_locks" ("agentId", "resourceId", "holderId", "heldUntil", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: agents_observations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."agents_observations" ("id", "agentId", "observationScopeId", "marker", "text", "parentId", "tokenCount", "status", "supersededBy", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: agents_memory_entry_sources; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."agents_memory_entry_sources" ("id", "agentId", "memoryEntryId", "observationId", "threadId", "evidenceHash", "evidenceText", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: agents_messages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."agents_messages" ("id", "threadId", "resourceId", "role", "type", "content", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: agents_observation_cursors; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."agents_observation_cursors" ("agentId", "observationScopeId", "lastObservedMessageId", "lastObservedAt", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: agents_observation_locks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."agents_observation_locks" ("agentId", "observationScopeId", "taskKind", "holderId", "heldUntil", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: folder; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."folder" ("id", "name", "parentFolderId", "projectId", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: instance_ai_threads; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."instance_ai_threads" ("id", "resourceId", "title", "metadata", "createdAt", "updatedAt", "projectId") FROM stdin;
\.


--
-- Data for Name: workflow_entity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."workflow_entity" ("name", "active", "nodes", "connections", "createdAt", "updatedAt", "settings", "staticData", "pinData", "versionId", "triggerCount", "id", "meta", "parentFolderId", "isArchived", "versionCounter", "description", "activeVersionId", "nodeGroups", "sourceWorkflowId") FROM stdin;
My workflow	f	[{"parameters":{"rule":{"interval":[{"field":"minutes","minutesInterval":30}]}},"type":"n8n-nodes-base.scheduleTrigger","typeVersion":1.3,"position":[-256,-64],"id":"ac15a515-fabd-429a-985d-4a06ebf49f3c","name":"Schedule Trigger"},{"parameters":{"sendTo":"lilininilikeu@gmail.com","subject":"You're getting this email because you're gay.","message":"it worked! NYAHAHAHAHHAHAHA","options":{"senderName":"Alex Cutie"}},"type":"n8n-nodes-base.gmail","typeVersion":2.2,"position":[-48,-64],"id":"7b97a9b6-e37b-4bd2-a6bb-295648d5fd2b","name":"Send a message","webhookId":"ae9af7fc-93b2-4500-9302-a5df83ef5ac2","alwaysOutputData":false,"retryOnFail":false,"notesInFlow":false,"credentials":{"gmailOAuth2":{"id":"m1wdLMxqifebWQO5","name":"Gmail account"}}}]	{"Schedule Trigger":{"main":[[{"node":"Send a message","type":"main","index":0}]]}}	2026-07-25 09:27:52.17+00	2026-07-25 09:37:41.738+00	{"executionOrder":"v1","binaryMode":"separate","availableInMCP":false}	{"node:Schedule Trigger":{"recurrenceRules":[null],"recurrenceRuleSignatures":[null]}}	{}	02a02cd5-1e42-4fd5-a557-9deda19f620d	1	1AzpEC2wr7qj2qDP	{"templateCredsSetupCompleted":true}	\N	f	23	\N	\N	[]	\N
\.


--
-- Data for Name: ai_builder_temporary_workflow; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."ai_builder_temporary_workflow" ("workflowId", "threadId", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: annotation_tag_entity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."annotation_tag_entity" ("id", "name", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: auth_identity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."auth_identity" ("userId", "providerId", "providerType", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: auth_provider_sync_history; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."auth_provider_sync_history" ("id", "providerType", "runMode", "status", "startedAt", "endedAt", "scanned", "created", "updated", "disabled", "error") FROM stdin;
\.


--
-- Data for Name: binary_data; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."binary_data" ("fileId", "sourceType", "sourceId", "data", "mimeType", "fileName", "fileSize", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: dynamic_credential_resolver; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."dynamic_credential_resolver" ("id", "name", "type", "config", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: credentials_entity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."credentials_entity" ("name", "data", "type", "createdAt", "updatedAt", "id", "isManaged", "isGlobal", "isResolvable", "resolvableAllowFallback", "resolverId") FROM stdin;
Gmail account	U2FsdGVkX1/vzvSRgDhpAqOH/slWHrEyJotqO5MELUg/ptaPuZoC3KB7NHg1q/No4e65FKlxmSueY1Tz3Wxuj9/Ray0OuBsyT3KFz5d8BYypuVGxM7mxkorPK6YtPWdlE7b9/Ta9tnYFHMboTWjOpTJWbglgteB+c11hr9PAdN2qW4vf+QxvVyTOg9Rs6cxxw5DA2a8Iq6uZEWk58EKf324gNOXZdSBbmTbVOEjhsypD+sX7laR237VitOi4gjd/fM3rjC7Vbml3moFuzoT4kC7GTj6BEhNZDA+tDAFl4Oq+sT666TeTSbuZbb1+P11yW08ZpC6GvkrJfbnEq1/x0At4TE/uTI122m4B9P67CH69I7Ry/0A9OjhJ412V5ToM0Fv0F5fZ0mDoNDnGRz0icxMd6JmjIjre5DUwk2nSE9JXPhfIQKkbt+mR8xFAycC+J+DDkTrj0nsRqMCW1CDB8Yygi5DnQ+kLS8Un5oOWCJ4iyP4P2d9rQVxSr2+CtlfiFxZgweod4fBF93cG1dhc4F9ayzmTXe3+OOH6toqQHC0vWgO4zLgBebs8ILMzSzVG+2eBChzXhAJowv8wT32xvCfm3YWcS41/CQSw2N8WSsw9o6BBVyF7Ie1/Lvr87UrDr8y4vyymQdI2opDYbJUI4nbyG9Fy2Peq0gsKGFdndglV0tSChiUmkFk8tSZlAOXfm7j+G8e7dJ8KwcmkituA6kgoTQ5s3ZAh5rRJEASA+1oZ6ZdwIYyA/qFsBwYZ19sw5Q/wBd0KMt7d2rIOCqa6k8qJOcKhGieplWLxrFCXfHPlyWkyNiZZsSGP4Og0Un3ExV+iAnouP66nDme9iCadgwKgRXFwHFWn9hoRo+Vucs5w6k5plWen+XI15Rjro2seD86Q4MqCeD7iB8frp3/q48aQV3/7MuOZyGmkIRdrqG/gjGnpIrPzHEOIv+hxUV7oEwnhJHphlw61Xa2j/mP18OYNRV07TNgQVlr4Ev6t4+oZAvlSOdo0QEuSVoRcxH7Z9+8akf4xGU90YvKqzfSRoUicjkgIF4D4JYxlmOPB1JTFNVV7EyOATFUDmqbDf8wL8nKd6/Bwx7BjtFrpMsbBZLjQVVIfY75wlab8lpoWe8etzMrP1qoGvWR1KchGpleq63/GPbaDdzjD7XqbsWUy2RIxw07V4JA2QzPStL/s48Yu3Lt25gURrogQIAhdJLAC8evsJwP3QDg0wulv3fmP9Kj0UP1bxr7/ofWxzgY7FngTHjqXT4Bra4TCvLw4r+h86nG865MPiHXIp3XcLt3JzhzBFE3QtbkKMdMjLaw2HmmLQK2gZdaGgE1aUl+1MCMktjiFSO7qe8rLSrK2l6Y3NYKjlJ7g66fi2W+cjzQ3L7yd6XNf+u9ZUmHqgNsClsKvG5QKqNySzMh6Ji8tkdgXThQoJRzgMSdE3LooQZxr9bjbgIkxabkcxk9fnVDvINHvJsUqG8Ij6nBHmyfQkjsnncdmyyIxQUXrAxe50aWc+vLuTZXwqdad2wYyk1wYQUYY674k57Wt7gfZPGvDM24KCvcn5Q+0IzxaknPZ4ITrGuV6nKtYrvnOLI1rpi2ngclEdfNa7tHR1TWzUxh+p+d2XnH4AxoPsif/HbAEHljtMu2qYJvtdzh2k5HB3pj3rlsGDgIopwfybb8+KNj6TfxyZcc9ah2QW9vPBQwea2nCuFLoa/hyjnhiWhnkKLHJ1YPX6GvVIUejbz4KJOkAQI7L6mDwpgCNfmvBuGOMDTsBZJk=	gmailOAuth2	2026-07-25 09:37:39.825+00	2026-07-25 11:00:41.347+00	m1wdLMxqifebWQO5	f	f	f	f	\N
\.


--
-- Data for Name: chat_hub_agents; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."chat_hub_agents" ("id", "name", "description", "systemPrompt", "ownerId", "credentialId", "provider", "model", "createdAt", "updatedAt", "icon", "files", "suggestedPrompts") FROM stdin;
\.


--
-- Data for Name: chat_hub_tools; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."chat_hub_tools" ("id", "name", "type", "typeVersion", "ownerId", "definition", "enabled", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: chat_hub_agent_tools; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."chat_hub_agent_tools" ("agentId", "toolId") FROM stdin;
\.


--
-- Data for Name: chat_hub_sessions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."chat_hub_sessions" ("id", "title", "ownerId", "lastMessageAt", "credentialId", "provider", "model", "workflowId", "createdAt", "updatedAt", "agentId", "agentName", "type") FROM stdin;
\.


--
-- Data for Name: execution_entity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."execution_entity" ("id", "finished", "mode", "retryOf", "retrySuccessId", "startedAt", "stoppedAt", "waitTill", "status", "workflowId", "deletedAt", "createdAt", "storedAt", "tracingContext", "deduplicationKey", "jsonSizeBytes", "workflowVersionId", "binaryDataSizeBytes", "usedPrivateCredentials") FROM stdin;
1	t	manual	\N	\N	2026-07-25 09:28:11.565+00	2026-07-25 09:28:11.867+00	\N	success	1AzpEC2wr7qj2qDP	\N	2026-07-25 09:28:11.494+00	db	\N	\N	2285	ec4cd6a1-1406-4b3f-a085-0d46ff9695f4	0	f
8	t	trigger	\N	\N	2026-07-25 10:00:41.084+00	2026-07-25 10:00:41.91+00	\N	success	1AzpEC2wr7qj2qDP	\N	2026-07-25 10:00:41.064+00	db	\N	1AzpEC2wr7qj2qDP:ac15a515-fabd-429a-985d-4a06ebf49f3c:2026-07-25T10:00:41.000Z	2709	02a02cd5-1e42-4fd5-a557-9deda19f620d	0	f
2	t	manual	\N	\N	2026-07-25 09:28:16.802+00	2026-07-25 09:28:16.973+00	\N	success	1AzpEC2wr7qj2qDP	\N	2026-07-25 09:28:16.783+00	db	\N	\N	2284	ec4cd6a1-1406-4b3f-a085-0d46ff9695f4	0	f
3	f	manual	\N	\N	2026-07-25 09:29:53.301+00	2026-07-25 09:29:55.767+00	\N	error	1AzpEC2wr7qj2qDP	\N	2026-07-25 09:29:53.284+00	db	\N	\N	6122	92304a84-1b0d-4c29-ad09-2313f227f96d	0	f
4	f	manual	\N	\N	2026-07-25 09:30:07.837+00	2026-07-25 09:30:07.967+00	\N	error	1AzpEC2wr7qj2qDP	\N	2026-07-25 09:30:07.821+00	db	\N	\N	6198	98236191-0888-4bfd-ba5b-feb068ecf7cb	0	f
9	t	trigger	\N	\N	2026-07-25 10:30:41.071+00	2026-07-25 10:30:42.09+00	\N	success	1AzpEC2wr7qj2qDP	\N	2026-07-25 10:30:41.02+00	db	\N	1AzpEC2wr7qj2qDP:ac15a515-fabd-429a-985d-4a06ebf49f3c:2026-07-25T10:30:41.000Z	2709	02a02cd5-1e42-4fd5-a557-9deda19f620d	0	f
5	f	manual	\N	\N	2026-07-25 09:38:03.699+00	2026-07-25 09:38:03.875+00	\N	error	1AzpEC2wr7qj2qDP	\N	2026-07-25 09:38:03.68+00	db	\N	\N	6432	02a02cd5-1e42-4fd5-a557-9deda19f620d	0	f
6	t	manual	\N	\N	2026-07-25 09:51:02.416+00	2026-07-25 09:51:03.362+00	\N	success	1AzpEC2wr7qj2qDP	\N	2026-07-25 09:51:02.368+00	db	\N	\N	3368	02a02cd5-1e42-4fd5-a557-9deda19f620d	0	f
7	t	manual	\N	\N	2026-07-25 09:51:14.988+00	2026-07-25 09:51:15.795+00	\N	success	1AzpEC2wr7qj2qDP	\N	2026-07-25 09:51:14.961+00	db	\N	\N	3284	02a02cd5-1e42-4fd5-a557-9deda19f620d	0	f
10	t	trigger	\N	\N	2026-07-25 11:00:41.046+00	2026-07-25 11:00:42.019+00	\N	success	1AzpEC2wr7qj2qDP	\N	2026-07-25 11:00:41.008+00	db	\N	1AzpEC2wr7qj2qDP:ac15a515-fabd-429a-985d-4a06ebf49f3c:2026-07-25T11:00:41.000Z	2709	02a02cd5-1e42-4fd5-a557-9deda19f620d	0	f
11	t	trigger	\N	\N	2026-07-25 11:30:41.065+00	2026-07-25 11:30:41.867+00	\N	success	1AzpEC2wr7qj2qDP	\N	2026-07-25 11:30:41.011+00	db	\N	1AzpEC2wr7qj2qDP:ac15a515-fabd-429a-985d-4a06ebf49f3c:2026-07-25T11:30:41.000Z	2709	02a02cd5-1e42-4fd5-a557-9deda19f620d	0	f
\.


--
-- Data for Name: chat_hub_messages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."chat_hub_messages" ("id", "sessionId", "previousMessageId", "revisionOfMessageId", "retryOfMessageId", "type", "name", "content", "provider", "model", "workflowId", "executionId", "createdAt", "updatedAt", "agentId", "status", "attachments") FROM stdin;
\.


--
-- Data for Name: chat_hub_session_tools; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."chat_hub_session_tools" ("sessionId", "toolId") FROM stdin;
\.


--
-- Data for Name: credential_dependency; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."credential_dependency" ("id", "credentialId", "dependencyType", "dependencyId", "createdAt") FROM stdin;
\.


--
-- Data for Name: data_table; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."data_table" ("id", "name", "projectId", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: data_table_column; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."data_table_column" ("id", "name", "type", "index", "dataTableId", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: deployment_key; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."deployment_key" ("id", "type", "value", "algorithm", "status", "createdAt", "updatedAt") FROM stdin;
JFV0PxR4rhbbVm6N	instance.id	2348c86dd6e152b56e4cacd536b23a0d9c60f3b6614b12a2bdfbd19a48bf16df	\N	active	2026-07-25 07:45:50.768+00	2026-07-25 07:45:50.768+00
71i6OFNEqbTFIKcd	signing.hmac	964671327c927c61a82df4c25d25af5ab71898b1f6bf2082eb7a949956cd02ba	\N	active	2026-07-25 07:45:51.064+00	2026-07-25 07:45:51.064+00
A5PxRWBxmz2KsrQh	signing.jwt	67fb04a42f171ee3e85fa2f1b1ba0f4e23130c2babcc846c0b2337cdd6e8834e	\N	active	2026-07-25 07:45:51.271+00	2026-07-25 07:45:51.271+00
8sSwNuJM5SMZuBhd	signing.binary_data	Vcxk9ve23raa/XflL5yQ38koml+yyY+0ei7rUX81GXo=	\N	active	2026-07-25 07:45:51.474+00	2026-07-25 07:45:51.474+00
\.


--
-- Data for Name: dynamic_credential_entry; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."dynamic_credential_entry" ("credential_id", "subject_id", "resolver_id", "data", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: dynamic_credential_user_entry; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."dynamic_credential_user_entry" ("credentialId", "userId", "resolverId", "data", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: evaluation_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."evaluation_config" ("id", "workflowId", "name", "status", "invalidReason", "datasetSource", "datasetRef", "startNodeName", "endNodeName", "metrics", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: evaluation_collection; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."evaluation_collection" ("id", "name", "description", "workflowId", "evaluationConfigId", "createdById", "insightsCache", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: event_destinations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."event_destinations" ("id", "destination", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: execution_annotations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."execution_annotations" ("id", "executionId", "vote", "note", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: execution_annotation_tags; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."execution_annotation_tags" ("annotationId", "tagId") FROM stdin;
\.


--
-- Data for Name: execution_data; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."execution_data" ("executionId", "workflowData", "data", "workflowVersionId") FROM stdin;
1	{"id":"1AzpEC2wr7qj2qDP","name":"My workflow","nodes":[{"parameters":{"notice":"","rule":{"interval":[{"field":"minutes","minutesInterval":30}]}},"type":"n8n-nodes-base.scheduleTrigger","typeVersion":1.3,"position":[0,0],"id":"ac15a515-fabd-429a-985d-4a06ebf49f3c","name":"Schedule Trigger"}],"connections":{},"settings":{"executionOrder":"v1","binaryMode":"separate","availableInMCP":false},"nodeGroups":[]}	[{"version":1,"startData":"1","resultData":"2","executionData":"3","resumeToken":"4"},{"destinationNode":"5","runNodeFilter":"6"},{"runData":"7","pinData":"8","lastNodeExecuted":"9"},{"contextData":"10","nodeExecutionStack":"11","metadata":"12","waitingExecution":"13","waitingExecutionSource":"14","runtimeData":"15"},"e517d0b31ab03aa2b1ae17ad1b44019de510561047bba13df99c62b6354e76fe",{"nodeName":"9","mode":"16"},["9"],{"Schedule Trigger":"17"},{},"Schedule Trigger",{},[],{},{},{},{"version":1,"establishedAt":1784971691667,"source":"18","triggerNode":"19","redaction":"20","credentials":"21"},"inclusive",["22"],"manual",{"name":"9","type":"23"},{"version":2,"production":false,"manual":false,"source":"24"},"U2FsdGVkX1+o/L1/iyF1dXGzYjY8m4whmcl2xIwnfDj9/36fVDsmeoyp3evyOjpQv5c0bR0KY4TtlggNrh195+fv3fLuPMfHRt2Ij8VoLuAa1Svwx+ScL6jsC1tpFf3orwNVX16AEZQQ1WSLWgaCCAi55UM85zJNNcoWXFmm6i3yW38ugGJt4FcOwaKVS9vfs9CTi+wm2mgKgzED1K/kXNF2lN2L6zCz9HP5ND4Q/TvTkBRWwPjE3pfUYP0SpbHh9gD/d/aoj0BbUxHDgvnHx+4CJmjuNldtib7bF/0WS+cRSIfq1o4XTSR0B9SMHbIEP2+H7NHXTQRG9z1Ah1aCNW91R3ioi5Pa8GTXLpQBPSWrc1BxFhUOyxQOTXfoKRhVhmAvkQrMq3LZ6uD1vlA3TIoWdM7BnLUrJNeUGVVf2ArzBcUL6WHTYv45+Fg5RxRYduTWPtZmkhBygJfiltKQa5nCqy6yR4Fnzi8ShhL267sxgPcG62BpgcfwIiupF0yvijbzI5OjwfOgYoy21ZDAPw==",{"startTime":1784971691775,"executionIndex":0,"source":"25","hints":"26","executionTime":90,"executionStatus":"27","data":"28"},"n8n-nodes-base.scheduleTrigger","workflow",[],[],"success",{"main":"29"},["30"],["31"],{"json":"32","pairedItem":"33"},{"timestamp":"34","Readable date":"35","Readable time":"36","Day of week":"37","Year":"38","Month":"39","Day of month":"40","Hour":"41","Minute":"42","Second":"43","Timezone":"44"},{"item":0},"2026-07-25T05:28:11.780-04:00","July 25th 2026, 5:28:11 am","5:28:11 am","Saturday","2026","July","25","05","28","11","America/New_York (UTC-04:00)"]	ec4cd6a1-1406-4b3f-a085-0d46ff9695f4
2	{"id":"1AzpEC2wr7qj2qDP","name":"My workflow","nodes":[{"parameters":{"notice":"","rule":{"interval":[{"field":"minutes","minutesInterval":30}]}},"type":"n8n-nodes-base.scheduleTrigger","typeVersion":1.3,"position":[0,0],"id":"ac15a515-fabd-429a-985d-4a06ebf49f3c","name":"Schedule Trigger"}],"connections":{},"settings":{"executionOrder":"v1","binaryMode":"separate","availableInMCP":false},"nodeGroups":[]}	[{"version":1,"startData":"1","resultData":"2","executionData":"3","resumeToken":"4"},{"destinationNode":"5","runNodeFilter":"6"},{"runData":"7","pinData":"8","lastNodeExecuted":"9"},{"contextData":"10","nodeExecutionStack":"11","metadata":"12","waitingExecution":"13","waitingExecutionSource":"14","runtimeData":"15"},"d2d56f2793f09960c2894a647e560cc142e9501388addad6626db92947ef7c21",{"nodeName":"9","mode":"16"},["9"],{"Schedule Trigger":"17"},{},"Schedule Trigger",{},[],{},{},{},{"version":1,"establishedAt":1784971696876,"source":"18","triggerNode":"19","redaction":"20","credentials":"21"},"inclusive",["22"],"manual",{"name":"9","type":"23"},{"version":2,"production":false,"manual":false,"source":"24"},"U2FsdGVkX183pEIqgScSBxaO0MOZEb6EqKeOOkmuKL6mB5dMK6HEOvFJu65VGD22H31tfO8sHdl9fPf/MmWrtZFXZmyauzBGiXCrwRBE1kiX1KS3px6Uq6ByQNu3Pg0b3tvdNUPvj/49cBDKNFmx6UB1vgeda/7rwCpI8tWhpa2ICOTUcHsgEJmAnOf3yXOTL0BuVVI3lDWrpCHjrKsqOuKJTo6S2alPRk7yCOobS8+a2RR4Bw3Aq5w+zMWsnQC1RSgaGyyB8502lPhp1SDJRxbbdDPRCakmgHLVA3CHu+/yeaeFlASYvUaPpl7UEnKhm/pHLGrOFRD6FbsjZ8WaOcV0w8eZXTOT7X7l2lSjN4GhvoHU/g/1CVIsfrlz6ts+13mFUxs03yTH0VhLRiHcm1GaOumnvC2GkgL3DV+5W7dAMsXMG48rJm0/1N/2WZkAekd2cYTmQn+tPUX7KnAilAThohw0dH570Jt7XQ7qZNfZWOmvQ3eQnRrfaucjrilJz4KgCW/vXfrgB1v6ig/URw==",{"startTime":1784971696972,"executionIndex":0,"source":"25","hints":"26","executionTime":1,"executionStatus":"27","data":"28"},"n8n-nodes-base.scheduleTrigger","workflow",[],[],"success",{"main":"29"},["30"],["31"],{"json":"32","pairedItem":"33"},{"timestamp":"34","Readable date":"35","Readable time":"36","Day of week":"37","Year":"38","Month":"39","Day of month":"40","Hour":"41","Minute":"42","Second":"43","Timezone":"44"},{"item":0},"2026-07-25T05:28:16.972-04:00","July 25th 2026, 5:28:16 am","5:28:16 am","Saturday","2026","July","25","05","28","16","America/New_York (UTC-04:00)"]	ec4cd6a1-1406-4b3f-a085-0d46ff9695f4
3	{"id":"1AzpEC2wr7qj2qDP","name":"My workflow","nodes":[{"parameters":{"notice":"","rule":{"interval":[{"field":"minutes","minutesInterval":30}]}},"type":"n8n-nodes-base.scheduleTrigger","typeVersion":1.3,"position":[-256,-64],"id":"ac15a515-fabd-429a-985d-4a06ebf49f3c","name":"Schedule Trigger"},{"parameters":{"authentication":"oAuth2","resource":"message","operation":"send","sendTo":"lilininilikeu@gmail.com","subject":"You're getting this email because you're gay.","emailType":"html","message":"it worked! NYAHAHAHAHHAHAHA","options":{"senderName":"Alex Cutie"}},"type":"n8n-nodes-base.gmail","typeVersion":2.2,"position":[-48,-64],"id":"7b97a9b6-e37b-4bd2-a6bb-295648d5fd2b","name":"Send a message","webhookId":"ae9af7fc-93b2-4500-9302-a5df83ef5ac2","alwaysOutputData":false,"retryOnFail":true,"notesInFlow":false}],"connections":{"Schedule Trigger":{"main":[[{"node":"Send a message","type":"main","index":0}]]}},"settings":{"executionOrder":"v1","binaryMode":"separate","availableInMCP":false},"nodeGroups":[]}	[{"version":1,"startData":"1","resultData":"2","executionData":"3","resumeToken":"4"},{"destinationNode":"5","runNodeFilter":"6"},{"error":"7","runData":"8","pinData":"9","lastNodeExecuted":"10"},{"contextData":"11","nodeExecutionStack":"12","metadata":"13","waitingExecution":"14","waitingExecutionSource":"15","runtimeData":"16"},"f1d9b9b6dac1aa74dba863292a6807e5df75ed7e2819e8a690066e52cc0f4b9d",{"nodeName":"10","mode":"17"},["18","10"],{"level":"19","shouldReport":true,"tags":"20","timestamp":1784971795765,"context":"21","functionality":"22","name":"23","node":"24","messages":"25","message":"26","stack":"27"},{"Schedule Trigger":"28","Send a message":"29"},{},"Send a message",{},["30"],{},{},{},{"version":1,"establishedAt":1784971793393,"source":"31","triggerNode":"32","redaction":"33","credentials":"34"},"inclusive","Schedule Trigger","warning",{"reWrapped":true},{"itemIndex":0},"regular","NodeOperationError",{"parameters":"35","type":"36","typeVersion":2.2,"position":"37","id":"38","name":"10","webhookId":"39","alwaysOutputData":false,"retryOnFail":true,"notesInFlow":false},["40"],"Node does not have any credentials set (item 0)","NodeOperationError: Node does not have any credentials set (item 0)\\n    at ExecuteContext.execute (/usr/local/lib/node_modules/n8n/node_modules/.pnpm/n8n-nodes-base@file+packages+nodes-base_@opentelemetry+api@1.9.0_@opentelemetry+exporte_9e31dcec10980323a9c957753d2416c7/node_modules/n8n-nodes-base/nodes/Google/Gmail/v2/GmailV2.node.ts:826:11)\\n    at WorkflowExecute.executeNode (/usr/local/lib/node_modules/n8n/node_modules/.pnpm/n8n-core@file+packages+core_@opentelemetry+api@1.9.0_@opentelemetry+exporter-trace-otlp_56f5a5be5f9a76dfbcdc404d6ec4dea5/node_modules/n8n-core/src/execution-engine/workflow-execute.ts:1081:8)\\n    at WorkflowExecute.runNode (/usr/local/lib/node_modules/n8n/node_modules/.pnpm/n8n-core@file+packages+core_@opentelemetry+api@1.9.0_@opentelemetry+exporter-trace-otlp_56f5a5be5f9a76dfbcdc404d6ec4dea5/node_modules/n8n-core/src/execution-engine/workflow-execute.ts:1381:11)\\n    at /usr/local/lib/node_modules/n8n/node_modules/.pnpm/n8n-core@file+packages+core_@opentelemetry+api@1.9.0_@opentelemetry+exporter-trace-otlp_56f5a5be5f9a76dfbcdc404d6ec4dea5/node_modules/n8n-core/src/execution-engine/workflow-execute.ts:1854:27\\n    at /usr/local/lib/node_modules/n8n/node_modules/.pnpm/n8n-core@file+packages+core_@opentelemetry+api@1.9.0_@opentelemetry+exporter-trace-otlp_56f5a5be5f9a76dfbcdc404d6ec4dea5/node_modules/n8n-core/src/execution-engine/workflow-execute.ts:2546:11",["41"],["42"],{"node":"43","data":"44","source":"45"},"manual",{"name":"10","type":"36"},{"version":2,"production":false,"manual":false,"source":"46"},"U2FsdGVkX18V7l4xFxVmtCw6ZEaGC7tnIsPe5PQwACYW5HzopfpFm60bmP4yeO/hDHanN50zWSFTSOum7z4AfvvkaHalvSYiJLlLXDRWXhzLghyHepmmQfOv2zY3rt4wY1AQims6x2okPUvayTnTVS1qy7xfzJanGtcypklHq81V3p+gC1/thXNbX7ezN0Rrixd8iCNu6sUKi/nq/P2/v+KBVdFBOLy/HpBq3qi+J9GuKzwShmxzEzEZAduGFEif7EOE5pGNvQv9TlLo4hzo/CmCij/K5DO2ZsBC1mFxExQvCQy0fQqgFryczwrKDkrW/3lMYdhqXCaZN+PRDa96B0BVgNkE9aMOId4srckcePobz3fp32ri1in35NNBW22DFHTH2cBJj6MeSCY9dOOdVKxNzL3WmNhtIwuMk47IaXcAz5h16nxC9XHOoNG2cSrkuqz1/7g4dfs5aTAi9DhXf7MqjzO7VZYlmOv2arWHy1tpzUhyVe38ODGtlWLcMD/o2mpjTInciZq4DISYfRD1qw==",{"authentication":"47","resource":"48","operation":"49","sendTo":"50","subject":"51","emailType":"52","message":"53","options":"54"},"n8n-nodes-base.gmail",[-48,-64],"7b97a9b6-e37b-4bd2-a6bb-295648d5fd2b","ae9af7fc-93b2-4500-9302-a5df83ef5ac2","Node does not have any credentials set",{"startTime":1784971696972,"executionIndex":0,"source":"55","hints":"56","executionTime":1,"executionStatus":"57","data":"58"},{"startTime":1784971793464,"executionIndex":1,"source":"59","hints":"60","executionTime":2302,"executionStatus":"61","error":"62"},{"parameters":"63","type":"36","typeVersion":2.2,"position":"64","id":"38","name":"10","webhookId":"39","alwaysOutputData":false,"retryOnFail":true,"notesInFlow":false},{"main":"65"},{"main":"59"},"workflow","oAuth2","message","send","lilininilikeu@gmail.com","You're getting this email because you're gay.","html","it worked! NYAHAHAHAHHAHAHA",{"senderName":"66"},[],[],"success",{"main":"67"},["68"],[],"error",{"level":"19","shouldReport":true,"tags":"20","timestamp":1784971795765,"context":"21","functionality":"22","name":"23","node":"24","messages":"25","message":"26","stack":"27"},{"authentication":"47","resource":"48","operation":"49","sendTo":"50","subject":"51","emailType":"52","message":"53","options":"69"},[-48,-64],["70"],"Alex Cutie",["71"],{"previousNode":"18","previousNodeOutput":0,"previousNodeRun":0},{"senderName":"66"},["72"],["73"],{"json":"74","pairedItem":"75"},{"json":"74","pairedItem":"76"},{"timestamp":"77","Readable date":"78","Readable time":"79","Day of week":"80","Year":"81","Month":"82","Day of month":"83","Hour":"84","Minute":"85","Second":"86","Timezone":"87"},{"item":0},{"item":0},"2026-07-25T05:28:16.972-04:00","July 25th 2026, 5:28:16 am","5:28:16 am","Saturday","2026","July","25","05","28","16","America/New_York (UTC-04:00)"]	92304a84-1b0d-4c29-ad09-2313f227f96d
4	{"id":"1AzpEC2wr7qj2qDP","name":"My workflow","nodes":[{"parameters":{"notice":"","rule":{"interval":[{"field":"minutes","minutesInterval":30}]}},"type":"n8n-nodes-base.scheduleTrigger","typeVersion":1.3,"position":[-256,-64],"id":"ac15a515-fabd-429a-985d-4a06ebf49f3c","name":"Schedule Trigger"},{"parameters":{"authentication":"oAuth2","resource":"message","operation":"send","sendTo":"lilininilikeu@gmail.com","subject":"You're getting this email because you're gay.","emailType":"html","message":"it worked! NYAHAHAHAHHAHAHA","options":{"senderName":"Alex Cutie"}},"type":"n8n-nodes-base.gmail","typeVersion":2.2,"position":[-48,-64],"id":"7b97a9b6-e37b-4bd2-a6bb-295648d5fd2b","name":"Send a message","webhookId":"ae9af7fc-93b2-4500-9302-a5df83ef5ac2","alwaysOutputData":false,"retryOnFail":false,"notesInFlow":false}],"connections":{"Schedule Trigger":{"main":[[{"node":"Send a message","type":"main","index":0}]]}},"settings":{"executionOrder":"v1","binaryMode":"separate","availableInMCP":false},"nodeGroups":[]}	[{"version":1,"startData":"1","resultData":"2","executionData":"3","resumeToken":"4"},{"destinationNode":"5","runNodeFilter":"6"},{"error":"7","runData":"8","pinData":"9","lastNodeExecuted":"10"},{"contextData":"11","nodeExecutionStack":"12","metadata":"13","waitingExecution":"14","waitingExecutionSource":"15","runtimeData":"16"},"0552bad85e0eb3ae670c81e619790f4546dd86fc8b421ec363d15253d2d7aa6b",{"nodeName":"10","mode":"17"},["18","10"],{"level":"19","shouldReport":true,"tags":"20","timestamp":1784971807966,"context":"21","functionality":"22","name":"23","node":"24","messages":"25","message":"26","stack":"27"},{"Schedule Trigger":"28","Send a message":"29"},{},"Send a message",{},["30"],{},{},{},{"version":1,"establishedAt":1784971807880,"source":"31","triggerNode":"32","redaction":"33","credentials":"34"},"inclusive","Schedule Trigger","warning",{"reWrapped":true},{"itemIndex":0},"regular","NodeOperationError",{"parameters":"35","type":"36","typeVersion":2.2,"position":"37","id":"38","name":"10","webhookId":"39","alwaysOutputData":false,"retryOnFail":false,"notesInFlow":false},["40"],"Node does not have any credentials set (item 0)","NodeOperationError: Node does not have any credentials set (item 0)\\n    at ExecuteContext.execute (/usr/local/lib/node_modules/n8n/node_modules/.pnpm/n8n-nodes-base@file+packages+nodes-base_@opentelemetry+api@1.9.0_@opentelemetry+exporte_9e31dcec10980323a9c957753d2416c7/node_modules/n8n-nodes-base/nodes/Google/Gmail/v2/GmailV2.node.ts:826:11)\\n    at processTicksAndRejections (node:internal/process/task_queues:104:5)\\n    at WorkflowExecute.executeNode (/usr/local/lib/node_modules/n8n/node_modules/.pnpm/n8n-core@file+packages+core_@opentelemetry+api@1.9.0_@opentelemetry+exporter-trace-otlp_56f5a5be5f9a76dfbcdc404d6ec4dea5/node_modules/n8n-core/src/execution-engine/workflow-execute.ts:1081:8)\\n    at WorkflowExecute.runNode (/usr/local/lib/node_modules/n8n/node_modules/.pnpm/n8n-core@file+packages+core_@opentelemetry+api@1.9.0_@opentelemetry+exporter-trace-otlp_56f5a5be5f9a76dfbcdc404d6ec4dea5/node_modules/n8n-core/src/execution-engine/workflow-execute.ts:1381:11)\\n    at /usr/local/lib/node_modules/n8n/node_modules/.pnpm/n8n-core@file+packages+core_@opentelemetry+api@1.9.0_@opentelemetry+exporter-trace-otlp_56f5a5be5f9a76dfbcdc404d6ec4dea5/node_modules/n8n-core/src/execution-engine/workflow-execute.ts:1854:27\\n    at /usr/local/lib/node_modules/n8n/node_modules/.pnpm/n8n-core@file+packages+core_@opentelemetry+api@1.9.0_@opentelemetry+exporter-trace-otlp_56f5a5be5f9a76dfbcdc404d6ec4dea5/node_modules/n8n-core/src/execution-engine/workflow-execute.ts:2546:11",["41"],["42"],{"node":"43","data":"44","source":"45"},"manual",{"name":"10","type":"36"},{"version":2,"production":false,"manual":false,"source":"46"},"U2FsdGVkX1+Itke+sgUng//+alWNeTnlkxhgEY4K0eGL3fP/94aCBOu5a1TO1ibwZYrMjJk6jshpU17UX46Nnesa9Tw5hK1Y5M8UgclX5rix0MUScHVGz+yVJfwfuIe7yOG+3KhjJNbjazgENZDL0X6V4UMeGhA4ijQO5+W2YeSOkn8Kkh+NTafsefUuhKlc22Tgy7XyypnhX3c14vEihOZ5Z5Hyi9KJ4VgcEmVI3e4DPAGEyyCkHvsDLTsxJRERWhfwEIfFuXKUZkMf613neXJi7K3JgIQHgxOhocMPPePVWMrBVD9eGPH8ZHO+M35apyPv669a64LTqJWv+JEqLxX4CMw9ZV9kcPd5mgPL/E5pNAzbHcxfSBV9VMdcVsebVrEQ/qaSTHao+bxjwweZ/AxxpYrKkwcfge9GVKjtNLhvfwFwBRO9sYennVYXVK4M/K7ktWWU2VZzLud+dtWThwaQzh7+ZNERoU5n1/iBm4CirLSuwWz2Z2jYOR4HdLa5/y3BXmSK/5nBgWgLFLLujA==",{"authentication":"47","resource":"48","operation":"49","sendTo":"50","subject":"51","emailType":"52","message":"53","options":"54"},"n8n-nodes-base.gmail",[-48,-64],"7b97a9b6-e37b-4bd2-a6bb-295648d5fd2b","ae9af7fc-93b2-4500-9302-a5df83ef5ac2","Node does not have any credentials set",{"startTime":1784971696972,"executionIndex":0,"source":"55","hints":"56","executionTime":1,"executionStatus":"57","data":"58"},{"startTime":1784971807964,"executionIndex":1,"source":"59","hints":"60","executionTime":2,"executionStatus":"61","error":"62"},{"parameters":"63","type":"36","typeVersion":2.2,"position":"64","id":"38","name":"10","webhookId":"39","alwaysOutputData":false,"retryOnFail":false,"notesInFlow":false},{"main":"65"},{"main":"59"},"workflow","oAuth2","message","send","lilininilikeu@gmail.com","You're getting this email because you're gay.","html","it worked! NYAHAHAHAHHAHAHA",{"senderName":"66"},[],[],"success",{"main":"67"},["68"],[],"error",{"level":"19","shouldReport":true,"tags":"20","timestamp":1784971807966,"context":"21","functionality":"22","name":"23","node":"24","messages":"25","message":"26","stack":"27"},{"authentication":"47","resource":"48","operation":"49","sendTo":"50","subject":"51","emailType":"52","message":"53","options":"69"},[-48,-64],["70"],"Alex Cutie",["71"],{"previousNode":"18","previousNodeOutput":0,"previousNodeRun":0},{"senderName":"66"},["72"],["73"],{"json":"74","pairedItem":"75"},{"json":"74","pairedItem":"76"},{"timestamp":"77","Readable date":"78","Readable time":"79","Day of week":"80","Year":"81","Month":"82","Day of month":"83","Hour":"84","Minute":"85","Second":"86","Timezone":"87"},{"item":0},{"item":0},"2026-07-25T05:28:16.972-04:00","July 25th 2026, 5:28:16 am","5:28:16 am","Saturday","2026","July","25","05","28","16","America/New_York (UTC-04:00)"]	98236191-0888-4bfd-ba5b-feb068ecf7cb
7	{"id":"1AzpEC2wr7qj2qDP","name":"My workflow","nodes":[{"parameters":{"notice":"","rule":{"interval":[{"field":"minutes","minutesInterval":30}]}},"type":"n8n-nodes-base.scheduleTrigger","typeVersion":1.3,"position":[-256,-64],"id":"ac15a515-fabd-429a-985d-4a06ebf49f3c","name":"Schedule Trigger"},{"parameters":{"authentication":"oAuth2","resource":"message","operation":"send","sendTo":"lilininilikeu@gmail.com","subject":"You're getting this email because you're gay.","emailType":"html","message":"it worked! NYAHAHAHAHHAHAHA","options":{"senderName":"Alex Cutie"}},"type":"n8n-nodes-base.gmail","typeVersion":2.2,"position":[-48,-64],"id":"7b97a9b6-e37b-4bd2-a6bb-295648d5fd2b","name":"Send a message","webhookId":"ae9af7fc-93b2-4500-9302-a5df83ef5ac2","alwaysOutputData":false,"retryOnFail":false,"notesInFlow":false,"credentials":{"gmailOAuth2":{"id":"m1wdLMxqifebWQO5","name":"Gmail account"}}}],"connections":{"Schedule Trigger":{"main":[[{"node":"Send a message","type":"main","index":0}]]}},"settings":{"executionOrder":"v1","binaryMode":"separate","availableInMCP":false},"nodeGroups":[]}	[{"version":1,"startData":"1","resultData":"2","executionData":"3","resumeToken":"4"},{},{"runData":"5","pinData":"6","lastNodeExecuted":"7"},{"contextData":"8","nodeExecutionStack":"9","metadata":"10","waitingExecution":"11","waitingExecutionSource":"12","runtimeData":"13"},"b60e7458b08e1dfe42ea29e38623802d317dd1f90f186aeb329ec7a287e98421",{"Schedule Trigger":"14","Send a message":"15"},{},"Send a message",{},[],{},{},{},{"version":1,"establishedAt":1784973075023,"source":"16","triggerNode":"17","redaction":"18","credentials":"19"},["20"],["21"],"manual",{"name":"22","type":"23"},{"version":2,"production":false,"manual":false,"source":"24"},"U2FsdGVkX19829edLQsMUFCqCWRDuT1Oos0KA6kzoqS1fHP0YST3V78Lu1LuQxFQ6TD07bsSpIX2NrLI/8te1QZ3YTC1F6eeRBHWf/zx8LwAIJybW2NRrdqpcpSVQicoXz1JFLiNorIt37gDGR7XsMCAV51MxWbCXqN1JCfMk+FKA2W8Wv6I4CiRxIcNl+ttD60g32y50ZMR8zHJ5MGqRuLbD5+spnaI5bdD3Z0s5ItikhRopne71VYgov2AeV/5BVoUWzQH63WrxXfT458bXu5mwKPG3crhDaHR1kpbVx/NuyOXo5ZWpe/C3k4Y4tVa63gjpcFrDKIQ51+3pfUfUWGRHobT9pt8yLkptVhOfxDOOIMksSTZ4RwaLLBOui7Jyi0IVmxYI3E9kvvZ3b5DmLE3PXVpmwcyk8gz6fZMdMxIsdKQNpsmxFxUqhR39M6P6/UMz8iMROYJPY22veJgbtaK9IALEADXCXUuuFbol7hicTyWD20MeP9Q4TEtuUi7NuejY0Xpb0olVSk1PDaVlQ==",{"startTime":1784973075062,"executionIndex":0,"source":"25","hints":"26","executionTime":4,"executionStatus":"27","data":"28"},{"startTime":1784973075067,"executionIndex":1,"source":"29","hints":"30","executionTime":728,"executionStatus":"27","data":"31"},"Schedule Trigger","n8n-nodes-base.scheduleTrigger","workflow",[],[],"success",{"main":"32"},["33"],[],{"main":"34"},["35"],{"previousNode":"22","previousNodeOutput":0,"previousNodeRun":0},["36"],["37"],["38"],{"json":"39","pairedItem":"40"},{"json":"41","pairedItem":"42"},{"timestamp":"43","Readable date":"44","Readable time":"45","Day of week":"46","Year":"47","Month":"48","Day of month":"49","Hour":"50","Minute":"51","Second":"52","Timezone":"53"},{"item":0},{"id":"54","threadId":"54","labelIds":"55"},{"item":0},"2026-07-25T05:51:15.064-04:00","July 25th 2026, 5:51:15 am","5:51:15 am","Saturday","2026","July","25","05","51","15","America/New_York (UTC-04:00)","19f98afa4724d976",["56"],"SENT"]	02a02cd5-1e42-4fd5-a557-9deda19f620d
9	{"id":"1AzpEC2wr7qj2qDP","name":"My workflow","nodes":[{"parameters":{"notice":"","rule":{"interval":[{"field":"minutes","minutesInterval":30}]}},"type":"n8n-nodes-base.scheduleTrigger","typeVersion":1.3,"position":[-256,-64],"id":"ac15a515-fabd-429a-985d-4a06ebf49f3c","name":"Schedule Trigger"},{"parameters":{"authentication":"oAuth2","resource":"message","operation":"send","sendTo":"lilininilikeu@gmail.com","subject":"You're getting this email because you're gay.","emailType":"html","message":"it worked! NYAHAHAHAHHAHAHA","options":{"senderName":"Alex Cutie"}},"type":"n8n-nodes-base.gmail","typeVersion":2.2,"position":[-48,-64],"id":"7b97a9b6-e37b-4bd2-a6bb-295648d5fd2b","name":"Send a message","webhookId":"ae9af7fc-93b2-4500-9302-a5df83ef5ac2","alwaysOutputData":false,"retryOnFail":false,"notesInFlow":false,"credentials":{"gmailOAuth2":{"id":"m1wdLMxqifebWQO5","name":"Gmail account"}}}],"connections":{"Schedule Trigger":{"main":[[{"node":"Send a message","type":"main","index":0}]]}},"settings":{"executionOrder":"v1","binaryMode":"separate","availableInMCP":false},"nodeGroups":[]}	[{"version":1,"startData":"1","resultData":"2","executionData":"3","resumeToken":"4"},{},{"runData":"5","lastNodeExecuted":"6"},{"contextData":"7","nodeExecutionStack":"8","metadata":"9","waitingExecution":"10","waitingExecutionSource":"11","runtimeData":"12"},"988ff0f11597835c5b0f87ae0e4607c0ac4feb1d826950932e030def8d5a9591",{"Schedule Trigger":"13","Send a message":"14"},"Send a message",{},[],{},{},{},{"version":1,"establishedAt":1784975441010,"source":"15","triggerNode":"16","redaction":"17"},["18"],["19"],"trigger",{"name":"20","type":"21"},{"version":2,"production":false,"manual":false,"source":"22"},{"startTime":1784975441299,"executionIndex":0,"source":"23","hints":"24","executionTime":0,"executionStatus":"25","data":"26"},{"startTime":1784975441299,"executionIndex":1,"source":"27","hints":"28","executionTime":791,"executionStatus":"25","data":"29"},"Schedule Trigger","n8n-nodes-base.scheduleTrigger","workflow",[],[],"success",{"main":"30"},["31"],[],{"main":"32"},["33"],{"previousNode":"20","previousNodeOutput":0,"previousNodeRun":0},["34"],["35"],["36"],{"json":"37","pairedItem":"38"},{"json":"39","pairedItem":"40"},{"timestamp":"41","Readable date":"42","Readable time":"43","Day of week":"44","Year":"45","Month":"46","Day of month":"47","Hour":"48","Minute":"49","Second":"50","Timezone":"51"},{"item":0},{"id":"52","threadId":"52","labelIds":"53"},{"item":0},"2026-07-25T06:30:41.009-04:00","July 25th 2026, 6:30:41 am","6:30:41 am","Saturday","2026","July","25","06","30","41","America/New_York (UTC-04:00)","19f98d3bf81712c5",["54"],"SENT"]	02a02cd5-1e42-4fd5-a557-9deda19f620d
5	{"id":"1AzpEC2wr7qj2qDP","name":"My workflow","nodes":[{"parameters":{"notice":"","rule":{"interval":[{"field":"minutes","minutesInterval":30}]}},"type":"n8n-nodes-base.scheduleTrigger","typeVersion":1.3,"position":[-256,-64],"id":"ac15a515-fabd-429a-985d-4a06ebf49f3c","name":"Schedule Trigger"},{"parameters":{"authentication":"oAuth2","resource":"message","operation":"send","sendTo":"lilininilikeu@gmail.com","subject":"You're getting this email because you're gay.","emailType":"html","message":"it worked! NYAHAHAHAHHAHAHA","options":{"senderName":"Alex Cutie"}},"type":"n8n-nodes-base.gmail","typeVersion":2.2,"position":[-48,-64],"id":"7b97a9b6-e37b-4bd2-a6bb-295648d5fd2b","name":"Send a message","webhookId":"ae9af7fc-93b2-4500-9302-a5df83ef5ac2","alwaysOutputData":false,"retryOnFail":false,"notesInFlow":false,"credentials":{"gmailOAuth2":{"id":"m1wdLMxqifebWQO5","name":"Gmail account"}}}],"connections":{"Schedule Trigger":{"main":[[{"node":"Send a message","type":"main","index":0}]]}},"settings":{"executionOrder":"v1","binaryMode":"separate","availableInMCP":false},"nodeGroups":[]}	[{"version":1,"startData":"1","resultData":"2","executionData":"3","resumeToken":"4"},{"destinationNode":"5","runNodeFilter":"6"},{"error":"7","runData":"8","pinData":"9","lastNodeExecuted":"10"},{"contextData":"11","nodeExecutionStack":"12","metadata":"13","waitingExecution":"14","waitingExecutionSource":"15","runtimeData":"16"},"1419467857085a588aa6361276b70286095d4b69c5db379abad3da29ac6ad086",{"nodeName":"10","mode":"17"},["18","10"],{"level":"19","shouldReport":true,"tags":"20","timestamp":1784972283874,"context":"21","functionality":"22","name":"23","node":"24","messages":"25","message":"26","stack":"27"},{"Schedule Trigger":"28","Send a message":"29"},{},"Send a message",{},["30"],{},{},{},{"version":1,"establishedAt":1784972283776,"source":"31","triggerNode":"32","redaction":"33","credentials":"34"},"inclusive","Schedule Trigger","warning",{"reWrapped":true},{"itemIndex":0},"regular","NodeOperationError",{"parameters":"35","type":"36","typeVersion":2.2,"position":"37","id":"38","name":"10","webhookId":"39","alwaysOutputData":false,"retryOnFail":false,"notesInFlow":false,"credentials":"40"},["41"],"Unable to sign without access token (item 0)","NodeOperationError: Unable to sign without access token (item 0)\\n    at ExecuteContext.execute (/usr/local/lib/node_modules/n8n/node_modules/.pnpm/n8n-nodes-base@file+packages+nodes-base_@opentelemetry+api@1.9.0_@opentelemetry+exporte_9e31dcec10980323a9c957753d2416c7/node_modules/n8n-nodes-base/nodes/Google/Gmail/v2/GmailV2.node.ts:826:11)\\n    at processTicksAndRejections (node:internal/process/task_queues:104:5)\\n    at WorkflowExecute.executeNode (/usr/local/lib/node_modules/n8n/node_modules/.pnpm/n8n-core@file+packages+core_@opentelemetry+api@1.9.0_@opentelemetry+exporter-trace-otlp_56f5a5be5f9a76dfbcdc404d6ec4dea5/node_modules/n8n-core/src/execution-engine/workflow-execute.ts:1081:8)\\n    at WorkflowExecute.runNode (/usr/local/lib/node_modules/n8n/node_modules/.pnpm/n8n-core@file+packages+core_@opentelemetry+api@1.9.0_@opentelemetry+exporter-trace-otlp_56f5a5be5f9a76dfbcdc404d6ec4dea5/node_modules/n8n-core/src/execution-engine/workflow-execute.ts:1381:11)\\n    at /usr/local/lib/node_modules/n8n/node_modules/.pnpm/n8n-core@file+packages+core_@opentelemetry+api@1.9.0_@opentelemetry+exporter-trace-otlp_56f5a5be5f9a76dfbcdc404d6ec4dea5/node_modules/n8n-core/src/execution-engine/workflow-execute.ts:1854:27\\n    at /usr/local/lib/node_modules/n8n/node_modules/.pnpm/n8n-core@file+packages+core_@opentelemetry+api@1.9.0_@opentelemetry+exporter-trace-otlp_56f5a5be5f9a76dfbcdc404d6ec4dea5/node_modules/n8n-core/src/execution-engine/workflow-execute.ts:2546:11",["42"],["43"],{"node":"44","data":"45","source":"46"},"manual",{"name":"10","type":"36"},{"version":2,"production":false,"manual":false,"source":"47"},"U2FsdGVkX18AUwzXOK1mfnhC8yXmLQ460uN+QxeFIJmbzBEc4HCv9HHZPiEbPUcjoc2sf9fLqu9hwFNzR9Ji+j+f+0iZMR0Jz6GwlHDAseWGZVQddeolmbEkMgucF02F8jtgril4ImFJ433vDTdI1TOV5WCLaaxo+9rOxOwdzGsF6ADvGiWKYVJmQ7+nUAFPhJfozi3yWyl7Jk82R+R3IVNfmG3o397swIioJtdKcqmWU6S0WFRPH1sej4bqUgMAfsftdGM2EHCft8RIoMWyZZo2lE4vK2jvjc6JlBrFSN5rbsC50Ibi8lGKXBzoa/roYpa2CDGd+GfpdSJ9Y9enwBMXT3qepN7THz9qQqRY6ZnsOm4VTsVRnG/tU0BtNKZt/N0v84KrY6GCeC9QXFV8AgMOOHlEoExSjVxQO5U5S1Z4J5XNweR6ZuoLl5S9apk8zseXeSMelpgcQkSC5jji2rfe/C/1u63rt9y7HEQk9BDoiRXOhgMZ0qy3G0Gh9JaD0/NVBgoeHQrgx1A551RIZQ==",{"authentication":"48","resource":"49","operation":"50","sendTo":"51","subject":"52","emailType":"53","message":"54","options":"55"},"n8n-nodes-base.gmail",[-48,-64],"7b97a9b6-e37b-4bd2-a6bb-295648d5fd2b","ae9af7fc-93b2-4500-9302-a5df83ef5ac2",{"gmailOAuth2":"56"},"Unable to sign without access token",{"startTime":1784971696972,"executionIndex":0,"source":"57","hints":"58","executionTime":1,"executionStatus":"59","data":"60"},{"startTime":1784972283862,"executionIndex":1,"source":"61","hints":"62","executionTime":12,"executionStatus":"63","error":"64"},{"parameters":"65","type":"36","typeVersion":2.2,"position":"66","id":"38","name":"10","webhookId":"39","alwaysOutputData":false,"retryOnFail":false,"notesInFlow":false,"credentials":"67"},{"main":"68"},{"main":"61"},"workflow","oAuth2","message","send","lilininilikeu@gmail.com","You're getting this email because you're gay.","html","it worked! NYAHAHAHAHHAHAHA",{"senderName":"69"},{"id":"70","name":"71"},[],[],"success",{"main":"72"},["73"],[],"error",{"level":"19","shouldReport":true,"tags":"20","timestamp":1784972283874,"context":"21","functionality":"22","name":"23","node":"24","messages":"25","message":"26","stack":"27"},{"authentication":"48","resource":"49","operation":"50","sendTo":"51","subject":"52","emailType":"53","message":"54","options":"74"},[-48,-64],{"gmailOAuth2":"75"},["76"],"Alex Cutie","m1wdLMxqifebWQO5","Gmail account",["77"],{"previousNode":"18","previousNodeOutput":0,"previousNodeRun":0},{"senderName":"69"},{"id":"70","name":"71"},["78"],["79"],{"json":"80","pairedItem":"81"},{"json":"80","pairedItem":"82"},{"timestamp":"83","Readable date":"84","Readable time":"85","Day of week":"86","Year":"87","Month":"88","Day of month":"89","Hour":"90","Minute":"91","Second":"92","Timezone":"93"},{"item":0},{"item":0},"2026-07-25T05:28:16.972-04:00","July 25th 2026, 5:28:16 am","5:28:16 am","Saturday","2026","July","25","05","28","16","America/New_York (UTC-04:00)"]	02a02cd5-1e42-4fd5-a557-9deda19f620d
6	{"id":"1AzpEC2wr7qj2qDP","name":"My workflow","nodes":[{"parameters":{"notice":"","rule":{"interval":[{"field":"minutes","minutesInterval":30}]}},"type":"n8n-nodes-base.scheduleTrigger","typeVersion":1.3,"position":[-256,-64],"id":"ac15a515-fabd-429a-985d-4a06ebf49f3c","name":"Schedule Trigger"},{"parameters":{"authentication":"oAuth2","resource":"message","operation":"send","sendTo":"lilininilikeu@gmail.com","subject":"You're getting this email because you're gay.","emailType":"html","message":"it worked! NYAHAHAHAHHAHAHA","options":{"senderName":"Alex Cutie"}},"type":"n8n-nodes-base.gmail","typeVersion":2.2,"position":[-48,-64],"id":"7b97a9b6-e37b-4bd2-a6bb-295648d5fd2b","name":"Send a message","webhookId":"ae9af7fc-93b2-4500-9302-a5df83ef5ac2","alwaysOutputData":false,"retryOnFail":false,"notesInFlow":false,"credentials":{"gmailOAuth2":{"id":"m1wdLMxqifebWQO5","name":"Gmail account"}}}],"connections":{"Schedule Trigger":{"main":[[{"node":"Send a message","type":"main","index":0}]]}},"settings":{"executionOrder":"v1","binaryMode":"separate","availableInMCP":false},"nodeGroups":[]}	[{"version":1,"startData":"1","resultData":"2","executionData":"3","resumeToken":"4"},{"destinationNode":"5","runNodeFilter":"6"},{"runData":"7","pinData":"8","lastNodeExecuted":"9"},{"contextData":"10","nodeExecutionStack":"11","metadata":"12","waitingExecution":"13","waitingExecutionSource":"14","runtimeData":"15"},"b8aff95fb94807f03601f76a8e00ae13b9cdd360e1ce10efba1b79f50fca5d14",{"nodeName":"9","mode":"16"},["17","9"],{"Schedule Trigger":"18","Send a message":"19"},{},"Send a message",{},[],{},{},{},{"version":1,"establishedAt":1784973062455,"source":"20","triggerNode":"21","redaction":"22","credentials":"23"},"inclusive","Schedule Trigger",["24"],["25"],"manual",{"name":"9","type":"26"},{"version":2,"production":false,"manual":false,"source":"27"},"U2FsdGVkX1/bxfJ5yC+tsOTxfqut5GxzLTBqblaufIIZj2w7deV7bY/W2HktSQjr9V48C28NIsDCT/XjPHORhn+dT0vs+EZIwYrHXa16AqskGU+58bpIYWlRXzdBaGF2c5hc503fzsOgEB40oRFZS9q+azgWHsqQtiWjIFKQeBWrmJibR1oT9wLM1fHW/p0Mc9KbagyP01YiZG0gTGAK1NLHAcIWPCXzS3lqT1nL9TP0TX+k32kdryfF1qi6tN3r2AezJ9xPBaXIKaaNVyekNSfXxe9D2Ia+H5YS7Zwsfyx87o6XZ8p13eBFeWCnDCNmdbzfHMobhvhrm/VqdRqF9Glc6l6Co8VHaOVlkjJ7do3DhKYqnaycJtc4zkbSCJ0v50O7D63y+G7aEYbjCi2VqxZIs+EvwydYbD41tj4WIVsj54xLii/AhfFQNBOybXTzYl3dWe572KAfmYE/tW642vUNYKdZyKYJRDhDiRaUmWa+tGFnMUaRCYHoQAstBcY9ntoW2kJO7i076zpFqMqp9Q==",{"startTime":1784971696972,"executionIndex":0,"source":"28","hints":"29","executionTime":1,"executionStatus":"30","data":"31"},{"startTime":1784973062478,"executionIndex":1,"source":"32","hints":"33","executionTime":883,"executionStatus":"30","data":"34"},"n8n-nodes-base.gmail","workflow",[],[],"success",{"main":"35"},["36"],[],{"main":"37"},["38"],{"previousNode":"17","previousNodeOutput":0,"previousNodeRun":0},["39"],["40"],["41"],{"json":"42","pairedItem":"43"},{"json":"44","pairedItem":"45"},{"timestamp":"46","Readable date":"47","Readable time":"48","Day of week":"49","Year":"50","Month":"51","Day of month":"52","Hour":"53","Minute":"54","Second":"55","Timezone":"56"},{"item":0},{"id":"57","threadId":"57","labelIds":"58"},{"item":0},"2026-07-25T05:28:16.972-04:00","July 25th 2026, 5:28:16 am","5:28:16 am","Saturday","2026","July","25","05","28","16","America/New_York (UTC-04:00)","19f98af73a501492",["59"],"SENT"]	02a02cd5-1e42-4fd5-a557-9deda19f620d
8	{"id":"1AzpEC2wr7qj2qDP","name":"My workflow","nodes":[{"parameters":{"notice":"","rule":{"interval":[{"field":"minutes","minutesInterval":30}]}},"type":"n8n-nodes-base.scheduleTrigger","typeVersion":1.3,"position":[-256,-64],"id":"ac15a515-fabd-429a-985d-4a06ebf49f3c","name":"Schedule Trigger"},{"parameters":{"authentication":"oAuth2","resource":"message","operation":"send","sendTo":"lilininilikeu@gmail.com","subject":"You're getting this email because you're gay.","emailType":"html","message":"it worked! NYAHAHAHAHHAHAHA","options":{"senderName":"Alex Cutie"}},"type":"n8n-nodes-base.gmail","typeVersion":2.2,"position":[-48,-64],"id":"7b97a9b6-e37b-4bd2-a6bb-295648d5fd2b","name":"Send a message","webhookId":"ae9af7fc-93b2-4500-9302-a5df83ef5ac2","alwaysOutputData":false,"retryOnFail":false,"notesInFlow":false,"credentials":{"gmailOAuth2":{"id":"m1wdLMxqifebWQO5","name":"Gmail account"}}}],"connections":{"Schedule Trigger":{"main":[[{"node":"Send a message","type":"main","index":0}]]}},"settings":{"executionOrder":"v1","binaryMode":"separate","availableInMCP":false},"nodeGroups":[]}	[{"version":1,"startData":"1","resultData":"2","executionData":"3","resumeToken":"4"},{},{"runData":"5","lastNodeExecuted":"6"},{"contextData":"7","nodeExecutionStack":"8","metadata":"9","waitingExecution":"10","waitingExecutionSource":"11","runtimeData":"12"},"3e1b5a673d299bde0af2ca39032d7f09ea2980eef8f84ea9fdd13efd06553251",{"Schedule Trigger":"13","Send a message":"14"},"Send a message",{},[],{},{},{},{"version":1,"establishedAt":1784973641063,"source":"15","triggerNode":"16","redaction":"17"},["18"],["19"],"trigger",{"name":"20","type":"21"},{"version":2,"production":false,"manual":false,"source":"22"},{"startTime":1784973641175,"executionIndex":0,"source":"23","hints":"24","executionTime":0,"executionStatus":"25","data":"26"},{"startTime":1784973641176,"executionIndex":1,"source":"27","hints":"28","executionTime":734,"executionStatus":"25","data":"29"},"Schedule Trigger","n8n-nodes-base.scheduleTrigger","workflow",[],[],"success",{"main":"30"},["31"],[],{"main":"32"},["33"],{"previousNode":"20","previousNodeOutput":0,"previousNodeRun":0},["34"],["35"],["36"],{"json":"37","pairedItem":"38"},{"json":"39","pairedItem":"40"},{"timestamp":"41","Readable date":"42","Readable time":"43","Day of week":"44","Year":"45","Month":"46","Day of month":"47","Hour":"48","Minute":"49","Second":"50","Timezone":"51"},{"item":0},{"id":"52","threadId":"52","labelIds":"53"},{"item":0},"2026-07-25T06:00:41.062-04:00","July 25th 2026, 6:00:41 am","6:00:41 am","Saturday","2026","July","25","06","00","41","America/New_York (UTC-04:00)","19f98b847bf27548",["54"],"SENT"]	02a02cd5-1e42-4fd5-a557-9deda19f620d
10	{"id":"1AzpEC2wr7qj2qDP","name":"My workflow","nodes":[{"parameters":{"notice":"","rule":{"interval":[{"field":"minutes","minutesInterval":30}]}},"type":"n8n-nodes-base.scheduleTrigger","typeVersion":1.3,"position":[-256,-64],"id":"ac15a515-fabd-429a-985d-4a06ebf49f3c","name":"Schedule Trigger"},{"parameters":{"authentication":"oAuth2","resource":"message","operation":"send","sendTo":"lilininilikeu@gmail.com","subject":"You're getting this email because you're gay.","emailType":"html","message":"it worked! NYAHAHAHAHHAHAHA","options":{"senderName":"Alex Cutie"}},"type":"n8n-nodes-base.gmail","typeVersion":2.2,"position":[-48,-64],"id":"7b97a9b6-e37b-4bd2-a6bb-295648d5fd2b","name":"Send a message","webhookId":"ae9af7fc-93b2-4500-9302-a5df83ef5ac2","alwaysOutputData":false,"retryOnFail":false,"notesInFlow":false,"credentials":{"gmailOAuth2":{"id":"m1wdLMxqifebWQO5","name":"Gmail account"}}}],"connections":{"Schedule Trigger":{"main":[[{"node":"Send a message","type":"main","index":0}]]}},"settings":{"executionOrder":"v1","binaryMode":"separate","availableInMCP":false},"nodeGroups":[]}	[{"version":1,"startData":"1","resultData":"2","executionData":"3","resumeToken":"4"},{},{"runData":"5","lastNodeExecuted":"6"},{"contextData":"7","nodeExecutionStack":"8","metadata":"9","waitingExecution":"10","waitingExecutionSource":"11","runtimeData":"12"},"8f89ed15204cdc7507a62a1fdc458d5b57f353d9cfc7412939286d37842b634c",{"Schedule Trigger":"13","Send a message":"14"},"Send a message",{},[],{},{},{},{"version":1,"establishedAt":1784977241008,"source":"15","triggerNode":"16","redaction":"17"},["18"],["19"],"trigger",{"name":"20","type":"21"},{"version":2,"production":false,"manual":false,"source":"22"},{"startTime":1784977241082,"executionIndex":0,"source":"23","hints":"24","executionTime":0,"executionStatus":"25","data":"26"},{"startTime":1784977241082,"executionIndex":1,"source":"27","hints":"28","executionTime":937,"executionStatus":"25","data":"29"},"Schedule Trigger","n8n-nodes-base.scheduleTrigger","workflow",[],[],"success",{"main":"30"},["31"],[],{"main":"32"},["33"],{"previousNode":"20","previousNodeOutput":0,"previousNodeRun":0},["34"],["35"],["36"],{"json":"37","pairedItem":"38"},{"json":"39","pairedItem":"40"},{"timestamp":"41","Readable date":"42","Readable time":"43","Day of week":"44","Year":"45","Month":"46","Day of month":"47","Hour":"48","Minute":"49","Second":"50","Timezone":"51"},{"item":0},{"id":"52","threadId":"52","labelIds":"53"},{"item":0},"2026-07-25T07:00:41.007-04:00","July 25th 2026, 7:00:41 am","7:00:41 am","Saturday","2026","July","25","07","00","41","America/New_York (UTC-04:00)","19f98ef36dae8acd",["54"],"SENT"]	02a02cd5-1e42-4fd5-a557-9deda19f620d
11	{"id":"1AzpEC2wr7qj2qDP","name":"My workflow","nodes":[{"parameters":{"notice":"","rule":{"interval":[{"field":"minutes","minutesInterval":30}]}},"type":"n8n-nodes-base.scheduleTrigger","typeVersion":1.3,"position":[-256,-64],"id":"ac15a515-fabd-429a-985d-4a06ebf49f3c","name":"Schedule Trigger"},{"parameters":{"authentication":"oAuth2","resource":"message","operation":"send","sendTo":"lilininilikeu@gmail.com","subject":"You're getting this email because you're gay.","emailType":"html","message":"it worked! NYAHAHAHAHHAHAHA","options":{"senderName":"Alex Cutie"}},"type":"n8n-nodes-base.gmail","typeVersion":2.2,"position":[-48,-64],"id":"7b97a9b6-e37b-4bd2-a6bb-295648d5fd2b","name":"Send a message","webhookId":"ae9af7fc-93b2-4500-9302-a5df83ef5ac2","alwaysOutputData":false,"retryOnFail":false,"notesInFlow":false,"credentials":{"gmailOAuth2":{"id":"m1wdLMxqifebWQO5","name":"Gmail account"}}}],"connections":{"Schedule Trigger":{"main":[[{"node":"Send a message","type":"main","index":0}]]}},"settings":{"executionOrder":"v1","binaryMode":"separate","availableInMCP":false},"nodeGroups":[]}	[{"version":1,"startData":"1","resultData":"2","executionData":"3","resumeToken":"4"},{},{"runData":"5","lastNodeExecuted":"6"},{"contextData":"7","nodeExecutionStack":"8","metadata":"9","waitingExecution":"10","waitingExecutionSource":"11","runtimeData":"12"},"caf89a08949d60914681f35c7818958fc282a5f47749f694e573aac708980b5e",{"Schedule Trigger":"13","Send a message":"14"},"Send a message",{},[],{},{},{},{"version":1,"establishedAt":1784979041011,"source":"15","triggerNode":"16","redaction":"17"},["18"],["19"],"trigger",{"name":"20","type":"21"},{"version":2,"production":false,"manual":false,"source":"22"},{"startTime":1784979041108,"executionIndex":0,"source":"23","hints":"24","executionTime":0,"executionStatus":"25","data":"26"},{"startTime":1784979041108,"executionIndex":1,"source":"27","hints":"28","executionTime":759,"executionStatus":"25","data":"29"},"Schedule Trigger","n8n-nodes-base.scheduleTrigger","workflow",[],[],"success",{"main":"30"},["31"],[],{"main":"32"},["33"],{"previousNode":"20","previousNodeOutput":0,"previousNodeRun":0},["34"],["35"],["36"],{"json":"37","pairedItem":"38"},{"json":"39","pairedItem":"40"},{"timestamp":"41","Readable date":"42","Readable time":"43","Day of week":"44","Year":"45","Month":"46","Day of month":"47","Hour":"48","Minute":"49","Second":"50","Timezone":"51"},{"item":0},{"id":"52","threadId":"52","labelIds":"53"},{"item":0},"2026-07-25T07:30:41.009-04:00","July 25th 2026, 7:30:41 am","7:30:41 am","Saturday","2026","July","25","07","30","41","America/New_York (UTC-04:00)","19f990aad3bc558f",["54"],"SENT"]	02a02cd5-1e42-4fd5-a557-9deda19f620d
\.


--
-- Data for Name: execution_metadata; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."execution_metadata" ("id", "executionId", "key", "value") FROM stdin;
\.


--
-- Data for Name: tag_entity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."tag_entity" ("name", "createdAt", "updatedAt", "id") FROM stdin;
\.


--
-- Data for Name: folder_tag; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."folder_tag" ("folderId", "tagId") FROM stdin;
\.


--
-- Data for Name: insights_metadata; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."insights_metadata" ("metaId", "workflowId", "projectId", "workflowName", "projectName") FROM stdin;
1	1AzpEC2wr7qj2qDP	mZfC7A4PSYI9o6Vm	My workflow	Nadz Gundaya <naagundaya@gmail.com>
\.


--
-- Data for Name: insights_by_period; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."insights_by_period" ("id", "metaId", "type", "value", "periodUnit", "periodStart") FROM stdin;
1	1	2	2	0	2026-07-25 10:00:00+00
2	1	0	0	0	2026-07-25 10:00:00+00
3	1	1	1529	0	2026-07-25 10:00:00+00
4	1	1	1698	0	2026-07-25 11:00:00+00
5	1	2	2	0	2026-07-25 11:00:00+00
6	1	0	0	0	2026-07-25 11:00:00+00
\.


--
-- Data for Name: insights_raw; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."insights_raw" ("id", "metaId", "type", "value", "timestamp") FROM stdin;
\.


--
-- Data for Name: installed_packages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."installed_packages" ("packageName", "installedVersion", "authorName", "authorEmail", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: installed_nodes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."installed_nodes" ("name", "type", "latestVersion", "package") FROM stdin;
\.


--
-- Data for Name: instance_ai_checkpoints; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."instance_ai_checkpoints" ("key", "runId", "threadId", "resourceId", "state", "createdAt", "updatedAt", "expiredAt") FROM stdin;
\.


--
-- Data for Name: instance_ai_iteration_logs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."instance_ai_iteration_logs" ("id", "threadId", "taskKey", "entry", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: mcp_registry_server; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."mcp_registry_server" ("slug", "status", "version", "registryUpdatedAt", "data", "createdAt", "updatedAt") FROM stdin;
notion	active	1.0.1	2026-06-11 12:29:07.703	{"id":1,"name":"com.notion/mcp","title":"Notion","tagline":"Connect to the Notion MCP Server","description":"Official Notion MCP server","websiteUrl":null,"authType":"oauth2","isOfficial":true,"isPublished":true,"origin":"registry","createdAt":"2026-05-19T16:49:13.571Z","publishedAt":"2026-06-18T09:50:05.210Z","remotes":[{"id":1,"type":"streamable-http","url":"https://mcp.notion.com/mcp"},{"id":2,"type":"sse","url":"https://mcp.notion.com/sse"}],"tools":[],"tags":{"data":[]},"extendsCredential":null,"icons":[{"src":"https://n8niostorageaccount.blob.core.windows.net/n8nio-strapi-blobs-prod/assets/idjb_Qg_E_jj_26d71d08b5.svg","mimeType":"image/svg+xml","theme":"dark"},{"src":"https://n8niostorageaccount.blob.core.windows.net/n8nio-strapi-blobs-prod/assets/idjb_Qg_E_jj_5fcfcab5f8.svg","mimeType":"image/svg+xml","theme":"light"}]}	2026-07-25 15:53:10.709+00	2026-07-25 15:53:10.709+00
atlassian	active	1.1.1	2026-06-11 12:28:42.32	{"id":2,"name":"com.atlassian/atlassian-mcp-server","title":"Atlassian","tagline":"Connect to the Atlassian MCP Server","description":"Atlassian Rovo MCP Server","websiteUrl":null,"authType":"oauth2","isOfficial":true,"isPublished":true,"origin":"registry","createdAt":"2026-05-19T16:49:24.904Z","publishedAt":"2026-06-18T09:50:05.210Z","remotes":[{"id":3,"type":"streamable-http","url":"https://mcp.atlassian.com/v1/mcp"},{"id":4,"type":"sse","url":"https://mcp.atlassian.com/v1/sse"}],"tools":[],"tags":{"data":[]},"extendsCredential":null,"icons":[{"src":"https://n8niostorageaccount.blob.core.windows.net/n8nio-strapi-blobs-prod/assets/id_KV_Ejn_Mrk_716d407499.svg","mimeType":"image/svg+xml","theme":"dark"},{"src":"https://n8niostorageaccount.blob.core.windows.net/n8nio-strapi-blobs-prod/assets/id_KV_Ejn_Mrk_1f404ecbfd.svg","mimeType":"image/svg+xml","theme":"light"}]}	2026-07-25 15:53:10.709+00	2026-07-25 15:53:10.709+00
apify	active	0.10.6	2026-06-11 12:28:32.446	{"id":3,"name":"com.apify/apify-mcp-server","title":"Apify","tagline":"Connect to the Apify MCP Server","description":"Extract data from any website with thousands of scrapers, crawlers, and automations on Apify Store ⚡","websiteUrl":null,"authType":"oauth2","isOfficial":true,"isPublished":true,"origin":"registry","createdAt":"2026-05-19T16:49:36.524Z","publishedAt":"2026-06-18T09:50:05.210Z","remotes":[{"id":5,"type":"streamable-http","url":"https://mcp.apify.com/"}],"tools":[],"tags":{"data":[]},"extendsCredential":null,"icons":[{"src":"https://n8niostorageaccount.blob.core.windows.net/n8nio-strapi-blobs-prod/assets/id_S_Uz5c4rz_d01d21b490.svg","mimeType":"image/svg+xml","theme":"dark"},{"src":"https://n8niostorageaccount.blob.core.windows.net/n8nio-strapi-blobs-prod/assets/id6k3_J_n_Mi_ceeccc3a3e.svg","mimeType":"image/svg+xml","theme":"light"}]}	2026-07-25 15:53:10.709+00	2026-07-25 15:53:10.709+00
stripe	active	0.2.4	2026-06-11 12:29:33.086	{"id":4,"name":"com.stripe/mcp","title":"Stripe","tagline":"Connect to the Stripe MCP Server","description":"MCP server integrating with Stripe - tools for customers, products, payments, and more.","websiteUrl":null,"authType":"oauth2","isOfficial":true,"isPublished":true,"origin":"registry","createdAt":"2026-05-19T16:49:47.930Z","publishedAt":"2026-06-18T09:50:05.210Z","remotes":[{"id":6,"type":"streamable-http","url":"https://mcp.stripe.com"}],"tools":[],"tags":{"data":[]},"extendsCredential":null,"icons":[{"src":"https://n8niostorageaccount.blob.core.windows.net/n8nio-strapi-blobs-prod/assets/id_Bn9_1_Njr_e4279db01b.jpeg","mimeType":"image/jpeg","theme":"light"}]}	2026-07-25 15:53:10.709+00	2026-07-25 15:53:10.709+00
monday-com	active	0.0.1	2026-06-11 12:29:02.947	{"id":5,"name":"com.monday/monday.com","title":"monday.com","tagline":"Connect to the monday.com MCP Server","description":"MCP server for monday.com integration.","websiteUrl":null,"authType":"oauth2","isOfficial":true,"isPublished":true,"origin":"registry","createdAt":"2026-05-19T16:49:59.434Z","publishedAt":"2026-06-18T09:50:05.210Z","remotes":[{"id":7,"type":"streamable-http","url":"https://mcp.monday.com/mcp"},{"id":8,"type":"sse","url":"https://mcp.monday.com/sse"}],"tools":[],"tags":{"data":[]},"extendsCredential":null,"icons":[{"src":"https://n8niostorageaccount.blob.core.windows.net/n8nio-strapi-blobs-prod/assets/idz_Vgm_C8_SV_4533eff3c2.svg","mimeType":"image/svg+xml","theme":"light"}]}	2026-07-25 15:53:10.709+00	2026-07-25 15:53:10.709+00
git-lab	active	0.0.1	2026-06-11 12:28:56.391	{"id":6,"name":"com.gitlab/mcp","title":"GitLab","tagline":"Connect to the GitLab MCP Server","description":"Official GitLab MCP Server","websiteUrl":null,"authType":"oauth2","isOfficial":true,"isPublished":true,"origin":"registry","createdAt":"2026-05-19T16:50:10.745Z","publishedAt":"2026-06-18T09:50:05.210Z","remotes":[{"id":9,"type":"streamable-http","url":"https://gitlab.com/api/v4/mcp"}],"tools":[],"tags":{"data":[]},"extendsCredential":null,"icons":[{"src":"https://n8niostorageaccount.blob.core.windows.net/n8nio-strapi-blobs-prod/assets/idkt3_Cw41b_9f7043ad83.svg","mimeType":"image/svg+xml","theme":"dark"},{"src":"https://n8niostorageaccount.blob.core.windows.net/n8nio-strapi-blobs-prod/assets/id_O_Daz_Q_Zbt_f76933a2e6.svg","mimeType":"image/svg+xml","theme":"light"}]}	2026-07-25 15:53:10.709+00	2026-07-25 15:53:10.709+00
linear	active	1.0.0	2026-06-11 12:28:04.979	{"id":7,"name":"app.linear/linear","title":"Linear","tagline":"Connect to the Linear MCP Server","description":"MCP server for Linear project management and issue tracking","websiteUrl":null,"authType":"oauth2","isOfficial":true,"isPublished":true,"origin":"registry","createdAt":"2026-05-19T16:50:22.156Z","publishedAt":"2026-06-18T09:50:05.210Z","remotes":[{"id":11,"type":"sse","url":"https://mcp.linear.app/sse"},{"id":10,"type":"streamable-http","url":"https://mcp.linear.app/mcp"}],"tools":[],"tags":{"data":[]},"extendsCredential":null,"icons":[{"src":"https://n8niostorageaccount.blob.core.windows.net/n8nio-strapi-blobs-prod/assets/id_P3_K9_Q_jj_6b6c66c6c7.svg","mimeType":"image/svg+xml","theme":"dark"},{"src":"https://n8niostorageaccount.blob.core.windows.net/n8nio-strapi-blobs-prod/assets/id_P3_K9_Q_jj_7d409a8856.svg","mimeType":"image/svg+xml","theme":"light"}]}	2026-07-25 15:53:10.709+00	2026-07-25 15:53:10.709+00
webflow	active	2.0.0	2026-06-11 12:29:37.869	{"id":8,"name":"com.webflow/mcp","title":"Webflow","tagline":"Connect to the Webflow MCP Server","description":"AI-powered design and management for Webflow Sites","websiteUrl":null,"authType":"oauth2","isOfficial":true,"isPublished":true,"origin":"registry","createdAt":"2026-05-19T16:50:33.630Z","publishedAt":"2026-06-18T09:50:05.210Z","remotes":[{"id":12,"type":"streamable-http","url":"https://mcp.webflow.com/mcp"}],"tools":[],"tags":{"data":[]},"extendsCredential":null,"icons":[{"src":"https://n8niostorageaccount.blob.core.windows.net/n8nio-strapi-blobs-prod/assets/idx_GYKE_Fj1_b568d3380a.svg","mimeType":"image/svg+xml","theme":"dark"},{"src":"https://n8niostorageaccount.blob.core.windows.net/n8nio-strapi-blobs-prod/assets/id_Zp72_NUI_5_080d2c331c.svg","mimeType":"image/svg+xml","theme":"light"}]}	2026-07-25 15:53:10.709+00	2026-07-25 15:53:10.709+00
pay-pal	active	1.0.0	2026-06-11 12:29:23.307	{"id":9,"name":"com.paypal.mcp/mcp","title":"PayPal","tagline":"Connect to the PayPal MCP Server","description":"PayPal MCP server provides access to PayPal services and operations for AI assistants","websiteUrl":null,"authType":"oauth2","isOfficial":true,"isPublished":true,"origin":"registry","createdAt":"2026-05-19T16:50:45.127Z","publishedAt":"2026-06-18T09:50:05.210Z","remotes":[{"id":13,"type":"streamable-http","url":"https://mcp.paypal.com/mcp"},{"id":14,"type":"sse","url":"https://mcp.paypal.com/sse"}],"tools":[],"tags":{"data":[]},"extendsCredential":null,"icons":[{"src":"https://n8niostorageaccount.blob.core.windows.net/n8nio-strapi-blobs-prod/assets/id_R_Wy_Aj_C_Dz_324a3b0a2e.svg","mimeType":"image/svg+xml","theme":"light"}]}	2026-07-25 15:53:10.709+00	2026-07-25 15:53:10.709+00
post-hog	active	0.2.5	2026-06-11 12:29:53.047	{"id":10,"name":"io.github.PostHog/mcp","title":"PostHog","tagline":"Connect to the PostHog MCP Server","description":"Official PostHog MCP Server for product analytics, feature flags, experiments, and more.","websiteUrl":null,"authType":"oauth2","isOfficial":true,"isPublished":true,"origin":"registry","createdAt":"2026-05-19T16:50:56.421Z","publishedAt":"2026-06-18T09:50:05.210Z","remotes":[{"id":16,"type":"streamable-http","url":"https://mcp.posthog.com/mcp"},{"id":15,"type":"sse","url":"https://mcp.posthog.com/sse"}],"tools":[],"tags":{"data":[]},"extendsCredential":null,"icons":[{"src":"https://n8niostorageaccount.blob.core.windows.net/n8nio-strapi-blobs-prod/assets/id_Yz0_Wt_S_Oc_8e4d0f0070.svg","mimeType":"image/svg+xml","theme":"light"}]}	2026-07-25 15:53:10.709+00	2026-07-25 15:53:10.709+00
amplitude	active	1.0.0	2026-06-11 12:28:25.27	{"id":11,"name":"com.amplitude/mcp-server","title":"Amplitude","tagline":"Connect to the Amplitude MCP Server","description":"Search, access, and get insights on your Amplitude data","websiteUrl":null,"authType":"oauth2","isOfficial":true,"isPublished":true,"origin":"registry","createdAt":"2026-05-19T16:51:08.257Z","publishedAt":"2026-06-18T09:50:05.210Z","remotes":[{"id":17,"type":"streamable-http","url":"https://mcp.amplitude.com/mcp"},{"id":18,"type":"streamable-http","url":"https://mcp.eu.amplitude.com/mcp"}],"tools":[],"tags":{"data":[]},"extendsCredential":null,"icons":[{"src":"https://n8niostorageaccount.blob.core.windows.net/n8nio-strapi-blobs-prod/assets/id_G_Fjvl8_Pa_bd331a64fc.svg","mimeType":"image/svg+xml","theme":"dark"},{"src":"https://n8niostorageaccount.blob.core.windows.net/n8nio-strapi-blobs-prod/assets/id_G_Fjvl8_Pa_a15896d97c.svg","mimeType":"image/svg+xml","theme":"light"}]}	2026-07-25 15:53:10.709+00	2026-07-25 15:53:10.709+00
postman	active	2.8.9	2026-06-11 12:29:28.445	{"id":12,"name":"com.postman/postman-mcp-server","title":"Postman","tagline":"Connect to the Postman MCP Server","description":"A basic MCP server to operate on the Postman API.","websiteUrl":null,"authType":"oauth2","isOfficial":true,"isPublished":true,"origin":"registry","createdAt":"2026-05-19T16:51:20.254Z","publishedAt":"2026-06-18T09:50:05.210Z","remotes":[{"id":19,"type":"streamable-http","url":"https://mcp.postman.com/mcp"},{"id":20,"type":"streamable-http","url":"https://mcp.postman.com/minimal"},{"id":21,"type":"streamable-http","url":"https://mcp.eu.postman.com/mcp"},{"id":22,"type":"streamable-http","url":"https://mcp.eu.postman.com/minimal"}],"tools":[],"tags":{"data":[]},"extendsCredential":null,"icons":[{"src":"https://n8niostorageaccount.blob.core.windows.net/n8nio-strapi-blobs-prod/assets/idr_UU_WRCO_c111cb0dea.png","mimeType":"image/png","theme":"light"}]}	2026-07-25 15:53:10.709+00	2026-07-25 15:53:10.709+00
close	active	1.0.1	2026-06-11 12:28:50.223	{"id":13,"name":"com.close/close-mcp","title":"Close","tagline":"Connect to the Close MCP Server","description":"Close CRM to manage your sales pipeline. Learn more at https://close.com or https://mcp.close.com","websiteUrl":null,"authType":"oauth2","isOfficial":true,"isPublished":true,"origin":"registry","createdAt":"2026-05-19T16:51:32.979Z","publishedAt":"2026-06-18T09:50:05.210Z","remotes":[{"id":23,"type":"streamable-http","url":"https://mcp.close.com/mcp"}],"tools":[],"tags":{"data":[]},"extendsCredential":null,"icons":[{"src":"https://n8niostorageaccount.blob.core.windows.net/n8nio-strapi-blobs-prod/assets/idpghi9sa_C_14d2cba8bf.png","mimeType":"image/png","theme":"light"}]}	2026-07-25 15:53:10.709+00	2026-07-25 15:53:10.709+00
wix	active	1.0.2	2026-06-11 12:29:47.22	{"id":14,"name":"com.wix/mcp","title":"Wix","tagline":"Connect to the Wix MCP Server","description":"A Model Context Protocol server for Wix AI tools","websiteUrl":null,"authType":"oauth2","isOfficial":true,"isPublished":true,"origin":"registry","createdAt":"2026-05-19T16:51:44.311Z","publishedAt":"2026-06-18T09:50:05.210Z","remotes":[{"id":24,"type":"sse","url":"https://mcp.wix.com/sse"},{"id":25,"type":"streamable-http","url":"https://mcp.wix.com/mcp"}],"tools":[],"tags":{"data":[]},"extendsCredential":null,"icons":[{"src":"https://n8niostorageaccount.blob.core.windows.net/n8nio-strapi-blobs-prod/assets/id_Qa_F_Jx_Orc_31d963143f.jpeg","mimeType":"image/jpeg","theme":"light"}]}	2026-07-25 15:53:10.709+00	2026-07-25 15:53:10.709+00
prisma	active	1.0.0	2026-06-11 12:30:05.827	{"id":15,"name":"io.prisma/mcp","title":"Prisma","tagline":"Connect to the Prisma MCP Server","description":"MCP server for managing Prisma Postgres.","websiteUrl":null,"authType":"oauth2","isOfficial":true,"isPublished":true,"origin":"registry","createdAt":"2026-05-19T16:51:55.545Z","publishedAt":"2026-06-18T09:50:05.210Z","remotes":[{"id":26,"type":"sse","url":"https://mcp.prisma.io/sse"},{"id":27,"type":"streamable-http","url":"https://mcp.prisma.io/mcp"}],"tools":[],"tags":{"data":[]},"extendsCredential":null,"icons":[{"src":"https://n8niostorageaccount.blob.core.windows.net/n8nio-strapi-blobs-prod/assets/idz_L_5t_H6_B_e6163aea2d.jpg","mimeType":"image/jpeg","theme":"light"}]}	2026-07-25 15:53:10.709+00	2026-07-25 15:53:10.709+00
sanity	active	2.19.0	2026-06-11 12:30:10.774	{"id":16,"name":"io.sanity.www/mcp","title":"Sanity","tagline":"Connect to the Sanity MCP Server","description":"Direct access to your Sanity projects (content, datasets, releases, schemas) and agent rules","websiteUrl":null,"authType":"oauth2","isOfficial":true,"isPublished":true,"origin":"registry","createdAt":"2026-05-19T16:52:07.029Z","publishedAt":"2026-06-18T09:50:05.210Z","remotes":[{"id":28,"type":"streamable-http","url":"https://mcp.sanity.io"}],"tools":[],"tags":{"data":[]},"extendsCredential":null,"icons":[{"src":"https://n8niostorageaccount.blob.core.windows.net/n8nio-strapi-blobs-prod/assets/id_Qr019q7c_e4c0ec82b7.png","mimeType":"image/png","theme":"light"}]}	2026-07-25 15:53:10.709+00	2026-07-25 15:53:10.709+00
axiom	active	1.0.0	2026-06-11 12:28:11.99	{"id":17,"name":"co.axiom/mcp","title":"Axiom","tagline":"Connect to the Axiom MCP Server","description":"List datasets, schemas, run APL queries, and use prompts for exploration, anomalies, and monitoring.","websiteUrl":null,"authType":"oauth2","isOfficial":true,"isPublished":true,"origin":"registry","createdAt":"2026-05-19T16:52:18.335Z","publishedAt":"2026-06-18T09:50:05.210Z","remotes":[{"id":30,"type":"sse","url":"https://mcp.axiom.co/sse"},{"id":29,"type":"streamable-http","url":"https://mcp.axiom.co/mcp"}],"tools":[],"tags":{"data":[]},"extendsCredential":null,"icons":[{"src":"https://n8niostorageaccount.blob.core.windows.net/n8nio-strapi-blobs-prod/assets/id_Xjr_Dncs4_d8a390ab33.jpeg","mimeType":"image/jpeg","theme":"light"}]}	2026-07-25 15:53:10.709+00	2026-07-25 15:53:10.709+00
hugging-face	active	0.2.33	2026-06-11 12:28:18.177	{"id":18,"name":"co.huggingface/hf-mcp-server","title":"Hugging Face","tagline":"Connect to the Hugging Face MCP Server","description":"Connect to Hugging Face Hub and thousands of Gradio AI Applications","websiteUrl":null,"authType":"oauth2","isOfficial":true,"isPublished":true,"origin":"registry","createdAt":"2026-05-19T16:52:30.024Z","publishedAt":"2026-06-18T09:50:05.210Z","remotes":[{"id":32,"type":"streamable-http","url":"https://huggingface.co/mcp?login"},{"id":31,"type":"streamable-http","url":"https://huggingface.co/mcp"},{"id":33,"type":"streamable-http","url":"https://huggingface.co/mcp"}],"tools":[],"tags":{"data":[]},"extendsCredential":null,"icons":[{"src":"https://n8niostorageaccount.blob.core.windows.net/n8nio-strapi-blobs-prod/assets/id_S6h_Od6z2_c35cc34669.jpeg","mimeType":"image/jpeg","theme":"light"}]}	2026-07-25 15:53:10.709+00	2026-07-25 15:53:10.709+00
unstoppable-domains	active	1.0.0	2026-07-27 06:25:24.004	{"id":19,"name":"com.unstoppabledomains/mcp-server","title":"Unstoppable Domains","tagline":"Connect to the Unstoppable Domains MCP Server","description":"Domain search, registration, DNS, marketplace, and checkout with your AI agent.","websiteUrl":null,"authType":"oauth2","isOfficial":true,"isPublished":true,"origin":"registry","createdAt":"2026-07-27T06:25:24.004Z","publishedAt":"2026-07-27T06:25:23.975Z","remotes":[{"id":34,"type":"streamable-http","url":"https://api.unstoppabledomains.com/mcp/v1/"}],"tools":[],"tags":{"data":[]},"extendsCredential":null,"icons":[{"src":"https://n8niostorageaccount.blob.core.windows.net/n8nio-strapi-blobs-prod/assets/id_Go_L_Bex_7_98cca38628.jpeg","mimeType":"image/jpeg","theme":"dark"}]}	2026-07-27 07:53:10.79+00	2026-07-27 07:53:10.79+00
you-com-web-access-ai	active	3.5.0	2026-07-27 06:25:36.296	{"id":20,"name":"io.github.youdotcom-oss/mcp","title":"You.com Web Access & AI","tagline":"Connect to the You.com Web Access & AI MCP Server","description":"Web search, AI agent, and content extraction via You.com APIs","websiteUrl":null,"authType":"oauth2","isOfficial":true,"isPublished":true,"origin":"registry","createdAt":"2026-07-27T06:25:36.296Z","publishedAt":"2026-07-27T06:25:36.279Z","remotes":[{"id":35,"type":"streamable-http","url":"https://api.you.com/mcp"}],"tools":[],"tags":{"data":[]},"extendsCredential":null,"icons":[{"src":"https://n8niostorageaccount.blob.core.windows.net/n8nio-strapi-blobs-prod/assets/idale_Bp_Jx_J_b69ac7e4b6.png","mimeType":"image/png","theme":"dark"}]}	2026-07-27 07:53:10.79+00	2026-07-27 07:53:10.79+00
tolstoy-library	active	1.0.0	2026-07-27 06:25:48.599	{"id":21,"name":"io.github.GoTolstoy/library","title":"Tolstoy Library","tagline":"Connect to the Tolstoy Library MCP Server","description":"Browse, search, rename, and favorite your Tolstoy media library from any AI client.","websiteUrl":null,"authType":"oauth2","isOfficial":true,"isPublished":true,"origin":"registry","createdAt":"2026-07-27T06:25:48.599Z","publishedAt":"2026-07-27T06:25:48.575Z","remotes":[{"id":36,"type":"streamable-http","url":"https://apilb.gotolstoy.com/mcp/v1/library/mcp"}],"tools":[],"tags":{"data":[]},"extendsCredential":null,"icons":[{"src":"https://n8niostorageaccount.blob.core.windows.net/n8nio-strapi-blobs-prod/assets/id1bfg_NL_0_W_a737f0b436.svg","mimeType":"image/svg+xml","theme":"light"},{"src":"https://n8niostorageaccount.blob.core.windows.net/n8nio-strapi-blobs-prod/assets/idswp_Hz_VRG_41aaa8f2a7.svg","mimeType":"image/svg+xml","theme":"dark"}]}	2026-07-27 07:53:10.79+00	2026-07-27 07:53:10.79+00
smart-bear	active	0.32.0	2026-07-27 06:26:00.585	{"id":22,"name":"com.smartbear/smartbear-mcp","title":"SmartBear","tagline":"Connect to the SmartBear MCP Server","description":"MCP server for AI access to SmartBear tools, including BugSnag, Reflect, Swagger, PactFlow, QTM4J.","websiteUrl":null,"authType":"oauth2","isOfficial":true,"isPublished":true,"origin":"registry","createdAt":"2026-07-27T06:26:00.585Z","publishedAt":"2026-07-27T06:26:00.567Z","remotes":[{"id":37,"type":"streamable-http","url":"https://bugsnag.mcp.smartbear.com/mcp"},{"id":38,"type":"streamable-http","url":"https://zephyr.mcp.smartbear.com/mcp"}],"tools":[],"tags":{"data":[]},"extendsCredential":null,"icons":[{"src":"https://n8niostorageaccount.blob.core.windows.net/n8nio-strapi-blobs-prod/assets/idi_Kc_F1m_Nh_08a3260e96.jpeg","mimeType":"image/jpeg","theme":"dark"}]}	2026-07-27 07:53:10.79+00	2026-07-27 07:53:10.79+00
egnyte-remote	active	1.0.0	2026-07-27 06:26:12.344	{"id":23,"name":"com.egnyte/mcp-server","title":"Egnyte Remote","tagline":"Connect to the Egnyte Remote MCP Server","description":"Egnyte's remote MCP server for secure AI access, search, upload and file management in your account.","websiteUrl":null,"authType":"oauth2","isOfficial":true,"isPublished":true,"origin":"registry","createdAt":"2026-07-27T06:26:12.344Z","publishedAt":"2026-07-27T06:26:12.319Z","remotes":[{"id":39,"type":"streamable-http","url":"https://mcp-server.egnyte.com/mcp"}],"tools":[],"tags":{"data":[]},"extendsCredential":null,"icons":[{"src":"https://n8niostorageaccount.blob.core.windows.net/n8nio-strapi-blobs-prod/assets/id_y3xa_T_9_348146b508.jpeg","mimeType":"image/jpeg","theme":"dark"}]}	2026-07-27 07:53:10.79+00	2026-07-27 07:53:10.79+00
airtable	active	0.1.0	2026-07-27 06:26:24.433	{"id":24,"name":"com.airtable/mcp","title":"Airtable","tagline":"Connect to the Airtable MCP Server","description":"Official Airtable MCP server — database and operations layer for agents.","websiteUrl":null,"authType":"oauth2","isOfficial":true,"isPublished":true,"origin":"registry","createdAt":"2026-07-27T06:26:24.433Z","publishedAt":"2026-07-27T06:26:24.412Z","remotes":[{"id":40,"type":"streamable-http","url":"https://mcp.airtable.com/mcp"}],"tools":[],"tags":{"data":[]},"extendsCredential":null,"icons":[{"src":"https://n8niostorageaccount.blob.core.windows.net/n8nio-strapi-blobs-prod/assets/id_RW_Qzz_VRI_a8b8b106af.svg","mimeType":"image/svg+xml","theme":"light"},{"src":"https://n8niostorageaccount.blob.core.windows.net/n8nio-strapi-blobs-prod/assets/iddyj0wl13_cb19e5e7fa.svg","mimeType":"image/svg+xml","theme":"dark"}]}	2026-07-27 07:53:10.79+00	2026-07-27 07:53:10.79+00
alchemy	active	0.5.2	2026-07-27 06:26:35.615	{"id":25,"name":"com.alchemy/mcp","title":"Alchemy","tagline":"Connect to the Alchemy MCP Server","description":"Blockchain data across 100+ chains: token prices, NFTs, transfers, simulation, traces, Solana DAS","websiteUrl":null,"authType":"oauth2","isOfficial":true,"isPublished":true,"origin":"registry","createdAt":"2026-07-27T06:26:35.615Z","publishedAt":"2026-07-27T06:26:35.599Z","remotes":[{"id":41,"type":"streamable-http","url":"https://mcp.alchemy.com/mcp"}],"tools":[],"tags":{"data":[]},"extendsCredential":null,"icons":[{"src":"https://n8niostorageaccount.blob.core.windows.net/n8nio-strapi-blobs-prod/assets/apple_touch_icon_824c201a3f.png","mimeType":"image/png"}]}	2026-07-27 07:53:10.79+00	2026-07-27 07:53:10.79+00
guru-remote	active	1.0.2	2026-07-27 06:26:47.365	{"id":26,"name":"com.getguru/mcp-server","title":"Guru Remote","tagline":"Connect to the Guru Remote MCP Server","description":"Guru MCP Server - Connect AI tools to your Guru knowledge base","websiteUrl":null,"authType":"oauth2","isOfficial":true,"isPublished":true,"origin":"registry","createdAt":"2026-07-27T06:26:47.365Z","publishedAt":"2026-07-27T06:26:47.339Z","remotes":[{"id":42,"type":"streamable-http","url":"https://mcp.api.getguru.com/mcp"}],"tools":[],"tags":{"data":[]},"extendsCredential":null,"icons":[{"src":"https://n8niostorageaccount.blob.core.windows.net/n8nio-strapi-blobs-prod/assets/id_KOIM_9_MG_a2d2a74e04.jpeg","mimeType":"image/jpeg","theme":"dark"}]}	2026-07-27 07:53:10.79+00	2026-07-27 07:53:10.79+00
avo	active	1.0.0	2026-07-27 06:26:59.555	{"id":27,"name":"io.github.avohq/avo","title":"Avo","tagline":"Connect to the Avo MCP Server","description":"Define, ship & query your analytics tracking from one source of truth, trusted by humans and agents.","websiteUrl":null,"authType":"oauth2","isOfficial":true,"isPublished":true,"origin":"registry","createdAt":"2026-07-27T06:26:59.555Z","publishedAt":"2026-07-27T06:26:59.535Z","remotes":[{"id":43,"type":"streamable-http","url":"https://mcp.avo.app/mcp"}],"tools":[],"tags":{"data":[]},"extendsCredential":null,"icons":[{"src":"https://n8niostorageaccount.blob.core.windows.net/n8nio-strapi-blobs-prod/assets/idr574_A_Kk_X_6db6ee0e4c.jpeg","mimeType":"image/jpeg","theme":"dark"}]}	2026-07-27 07:53:10.79+00	2026-07-27 07:53:10.79+00
flux	active	1.0.0	2026-07-27 06:27:11.348	{"id":28,"name":"io.github.black-forest-labs/flux-mcp","title":"FLUX","tagline":"Connect to the FLUX MCP Server","description":"Official FLUX MCP server. Generate, edit, vary, and browse images from Black Forest Labs.","websiteUrl":null,"authType":"oauth2","isOfficial":true,"isPublished":true,"origin":"registry","createdAt":"2026-07-27T06:27:11.348Z","publishedAt":"2026-07-27T06:27:11.334Z","remotes":[{"id":44,"type":"streamable-http","url":"https://mcp.bfl.ai"}],"tools":[],"tags":{"data":[]},"extendsCredential":null,"icons":[{"src":"https://n8niostorageaccount.blob.core.windows.net/n8nio-strapi-blobs-prod/assets/id_Lu4p_X9l_F_2d4acf82df.jpeg","mimeType":"image/jpeg","theme":"dark"}]}	2026-07-27 07:53:10.79+00	2026-07-27 07:53:10.79+00
bitrix-24	active	1.0.0	2026-07-27 06:27:23.396	{"id":29,"name":"io.github.bitrix24/bitrix24","title":"Bitrix24","tagline":"Connect to the Bitrix24 MCP Server","description":"MCP server enabling AI agents to manage Bitrix24 features via standardized protocol","websiteUrl":null,"authType":"oauth2","isOfficial":true,"isPublished":true,"origin":"registry","createdAt":"2026-07-27T06:27:23.396Z","publishedAt":"2026-07-27T06:27:23.360Z","remotes":[{"id":45,"type":"streamable-http","url":"https://mcp.bitrix24.com/mcp/"}],"tools":[],"tags":{"data":[]},"extendsCredential":null,"icons":[{"src":"https://n8niostorageaccount.blob.core.windows.net/n8nio-strapi-blobs-prod/assets/id_Fs_Tz_WJ_4_X_2dd0bbcd84.jpeg","mimeType":"image/jpeg","theme":"dark"}]}	2026-07-27 07:53:10.79+00	2026-07-27 07:53:10.79+00
c-data-connect-ai	active	1.0.0	2026-07-27 06:27:35.15	{"id":30,"name":"com.cdata/cdata-connect-ai","title":"CData Connect AI","tagline":"Connect to the CData Connect AI MCP Server","description":"Cloud-hosted MCP server for secure AI access to enterprise data sources via CData Connect AI.","websiteUrl":null,"authType":"oauth2","isOfficial":true,"isPublished":true,"origin":"registry","createdAt":"2026-07-27T06:27:35.150Z","publishedAt":"2026-07-27T06:27:35.130Z","remotes":[{"id":46,"type":"streamable-http","url":"https://mcp.cloud.cdata.com/mcp"}],"tools":[],"tags":{"data":[]},"extendsCredential":null,"icons":[{"src":"https://n8niostorageaccount.blob.core.windows.net/n8nio-strapi-blobs-prod/assets/id_XN_Pnsge_I_18a9c34852.jpeg","mimeType":"image/jpeg","theme":"dark"}]}	2026-07-27 07:53:10.79+00	2026-07-27 07:53:10.79+00
crypto-quant	active	0.1.1	2026-07-27 06:27:46.962	{"id":31,"name":"com.cryptoquant/mcp-server","title":"CryptoQuant","tagline":"Connect to the CryptoQuant MCP Server","description":"Query cryptocurrency on-chain data, OHLCV prices, market data, and Research & QuickTake insights.","websiteUrl":null,"authType":"oauth2","isOfficial":true,"isPublished":true,"origin":"registry","createdAt":"2026-07-27T06:27:46.962Z","publishedAt":"2026-07-27T06:27:46.944Z","remotes":[{"id":47,"type":"streamable-http","url":"https://mcp.cryptoquant.com/mcp"}],"tools":[],"tags":{"data":[]},"extendsCredential":null,"icons":[{"src":"https://n8niostorageaccount.blob.core.windows.net/n8nio-strapi-blobs-prod/assets/id_V_Lc_E486p_f1a6e16cf8.png","mimeType":"image/png","theme":"dark"}]}	2026-07-27 07:53:10.79+00	2026-07-27 07:53:10.79+00
cypress-cloud	active	1.0.0	2026-07-27 06:27:58.817	{"id":32,"name":"io.cypress.mcp/cypress-cloud","title":"Cypress Cloud","tagline":"Connect to the Cypress Cloud MCP Server","description":"Direct access to Cypress tests results and accessibility reports in your AI workflow.","websiteUrl":null,"authType":"oauth2","isOfficial":true,"isPublished":true,"origin":"registry","createdAt":"2026-07-27T06:27:58.817Z","publishedAt":"2026-07-27T06:27:58.799Z","remotes":[{"id":48,"type":"streamable-http","url":"https://mcp.cypress.io/mcp"}],"tools":[],"tags":{"data":[]},"extendsCredential":null,"icons":[{"src":"https://n8niostorageaccount.blob.core.windows.net/n8nio-strapi-blobs-prod/assets/idv3zwm_Si_Y_97b8f8b3d4.jpeg","mimeType":"image/jpeg","theme":"dark"}]}	2026-07-27 07:53:10.79+00	2026-07-27 07:53:10.79+00
exa	active	3.1.3	2026-07-27 06:28:10.635	{"id":33,"name":"ai.exa/exa","title":"Exa","tagline":"Connect to the Exa MCP Server","description":"Fast, intelligent web search and web crawling.\\n\\nNew mcp tool: Exa-code is a context tool for coding ","websiteUrl":null,"authType":"oauth2","isOfficial":true,"isPublished":true,"origin":"registry","createdAt":"2026-07-27T06:28:10.635Z","publishedAt":"2026-07-27T06:28:10.618Z","remotes":[{"id":49,"type":"streamable-http","url":"https://mcp.exa.ai/mcp"}],"tools":[],"tags":{"data":[]},"extendsCredential":null,"icons":[{"src":"https://n8niostorageaccount.blob.core.windows.net/n8nio-strapi-blobs-prod/assets/idek_S6b5_Vc_846a9be831.jpeg","mimeType":"image/jpeg","theme":"dark"}]}	2026-07-27 07:53:10.79+00	2026-07-27 07:53:10.79+00
fibery	active	1.0.0	2026-07-27 06:28:22.675	{"id":34,"name":"io.github.Fibery-inc/mcp","title":"Fibery","tagline":"Connect to the Fibery MCP Server","description":"Connect AI Assistant to Fibery — operating system for orgs run by nerds.","websiteUrl":null,"authType":"oauth2","isOfficial":true,"isPublished":true,"origin":"registry","createdAt":"2026-07-27T06:28:22.675Z","publishedAt":"2026-07-27T06:28:22.659Z","remotes":[{"id":50,"type":"streamable-http","url":"https://mcp.fibery.io/mcp"}],"tools":[],"tags":{"data":[]},"extendsCredential":null,"icons":[{"src":"https://n8niostorageaccount.blob.core.windows.net/n8nio-strapi-blobs-prod/assets/idc_Az9_Jna3_3655f33477.jpeg","mimeType":"image/jpeg","theme":"dark"}]}	2026-07-27 07:53:10.79+00	2026-07-27 07:53:10.79+00
grafana	active	v0.17.2	2026-07-27 06:28:34.695	{"id":35,"name":"io.github.grafana/mcp-grafana","title":"Grafana","tagline":"Connect to the Grafana MCP Server","description":"An MCP server giving access to Grafana dashboards, data and more.","websiteUrl":null,"authType":"oauth2","isOfficial":true,"isPublished":true,"origin":"registry","createdAt":"2026-07-27T06:28:34.695Z","publishedAt":"2026-07-27T06:28:34.675Z","remotes":[{"id":51,"type":"streamable-http","url":"https://mcp.grafana.com/mcp"}],"tools":[],"tags":{"data":[]},"extendsCredential":null,"icons":[{"src":"https://n8niostorageaccount.blob.core.windows.net/n8nio-strapi-blobs-prod/assets/id_Voh_Wbum_D_22ee5e3d3d.svg","mimeType":"image/svg+xml","theme":"light"},{"src":"https://n8niostorageaccount.blob.core.windows.net/n8nio-strapi-blobs-prod/assets/id_KI_2_Ge8_Tx_8fa7637298.svg","mimeType":"image/svg+xml","theme":"dark"}]}	2026-07-27 07:53:10.79+00	2026-07-27 07:53:10.79+00
hackle	active	1.0.0	2026-07-27 06:28:46.707	{"id":36,"name":"io.github.hackle-io/hackle-mcp","title":"Hackle","tagline":"Connect to the Hackle MCP Server","description":"Remote MCP server for the Hackle Admin API: experiments, feature flags, remote config, messaging.","websiteUrl":null,"authType":"oauth2","isOfficial":true,"isPublished":true,"origin":"registry","createdAt":"2026-07-27T06:28:46.707Z","publishedAt":"2026-07-27T06:28:46.687Z","remotes":[{"id":52,"type":"streamable-http","url":"https://mcp.hackle.io/mcp"}],"tools":[],"tags":{"data":[]},"extendsCredential":null,"icons":[{"src":"https://n8niostorageaccount.blob.core.windows.net/n8nio-strapi-blobs-prod/assets/idb_Cgt3_EZ_5_6022811256.png","mimeType":"image/png","theme":"dark"}]}	2026-07-27 07:53:10.79+00	2026-07-27 07:53:10.79+00
himalayas-remote-jobs	active	1.0.2	2026-07-27 06:28:57.931	{"id":37,"name":"app.himalayas/mcp","title":"Himalayas Remote Jobs","tagline":"Connect to the Himalayas Remote Jobs MCP Server","description":"Search and post remote jobs, browse companies, check salaries, and find talent on Himalayas.app","websiteUrl":null,"authType":"oauth2","isOfficial":true,"isPublished":true,"origin":"registry","createdAt":"2026-07-27T06:28:57.931Z","publishedAt":"2026-07-27T06:28:57.821Z","remotes":[{"id":53,"type":"streamable-http","url":"https://mcp.himalayas.app/mcp"},{"id":54,"type":"sse","url":"https://mcp.himalayas.app/sse"}],"tools":[],"tags":{"data":[]},"extendsCredential":null,"icons":[{"src":"https://n8niostorageaccount.blob.core.windows.net/n8nio-strapi-blobs-prod/assets/icon_80aa4c0cf9.png","mimeType":"image/png"}]}	2026-07-27 07:53:10.79+00	2026-07-27 07:53:10.79+00
honeycomb	active	1.0.0	2026-07-27 06:29:09.821	{"id":38,"name":"io.honeycomb/mcp","title":"Honeycomb","tagline":"Connect to the Honeycomb MCP Server","description":"Query Honeycomb observability data: traces, events, metrics, SLOs, triggers, and boards.","websiteUrl":null,"authType":"oauth2","isOfficial":true,"isPublished":true,"origin":"registry","createdAt":"2026-07-27T06:29:09.821Z","publishedAt":"2026-07-27T06:29:09.797Z","remotes":[{"id":55,"type":"streamable-http","url":"https://mcp.honeycomb.io/mcp"}],"tools":[],"tags":{"data":[]},"extendsCredential":null,"icons":[{"src":"https://n8niostorageaccount.blob.core.windows.net/n8nio-strapi-blobs-prod/assets/idc_Eu_Mai3_Y_51bd126c09.svg","mimeType":"image/svg+xml","theme":"light"},{"src":"https://n8niostorageaccount.blob.core.windows.net/n8nio-strapi-blobs-prod/assets/id_Zffh_QN_Fl_bfda41d0f1.svg","mimeType":"image/svg+xml","theme":"dark"}]}	2026-07-27 07:53:10.79+00	2026-07-27 07:53:10.79+00
jotform	active	1.0.0	2026-07-27 06:29:22.378	{"id":39,"name":"com.jotform/mcp","title":"Jotform","tagline":"Connect to the Jotform MCP Server","description":"Jotform MCP","websiteUrl":null,"authType":"oauth2","isOfficial":true,"isPublished":true,"origin":"registry","createdAt":"2026-07-27T06:29:22.378Z","publishedAt":"2026-07-27T06:29:22.358Z","remotes":[{"id":56,"type":"streamable-http","url":"https://mcp.jotform.com/"}],"tools":[],"tags":{"data":[]},"extendsCredential":null,"icons":[{"src":"https://n8niostorageaccount.blob.core.windows.net/n8nio-strapi-blobs-prod/assets/idcaz_TK_Ep1_099d00aa95.svg","mimeType":"image/svg+xml","theme":"light"},{"src":"https://n8niostorageaccount.blob.core.windows.net/n8nio-strapi-blobs-prod/assets/id_Rg_Fx_ND_Ty_d7d836bfa5.svg","mimeType":"image/svg+xml","theme":"dark"}]}	2026-07-27 07:53:10.79+00	2026-07-27 07:53:10.79+00
jumpcloud	active	0.0.38	2026-07-27 06:29:34.445	{"id":40,"name":"com.jumpcloud/jumpcloud-genai","title":"Jumpcloud","tagline":"Connect to the Jumpcloud MCP Server","description":"An MCP server that provides an API to LLMs to manage their JumpCloud resources.","websiteUrl":null,"authType":"oauth2","isOfficial":true,"isPublished":true,"origin":"registry","createdAt":"2026-07-27T06:29:34.445Z","publishedAt":"2026-07-27T06:29:34.429Z","remotes":[{"id":57,"type":"streamable-http","url":"https://mcp.jumpcloud.com/v1"}],"tools":[],"tags":{"data":[]},"extendsCredential":null,"icons":[{"src":"https://n8niostorageaccount.blob.core.windows.net/n8nio-strapi-blobs-prod/assets/id_Q_Wjip_S_Dg_57592c9ce8.jpeg","mimeType":"image/jpeg","theme":"dark"}]}	2026-07-27 07:53:10.79+00	2026-07-27 07:53:10.79+00
kajabi	active	1.0.0	2026-07-27 06:29:46.253	{"id":41,"name":"com.kajabi/kajabi","title":"Kajabi","tagline":"Connect to the Kajabi MCP Server","description":"Manage Kajabi from any MCP client — products, pages, contacts, offers, emails, analytics.","websiteUrl":null,"authType":"oauth2","isOfficial":true,"isPublished":true,"origin":"registry","createdAt":"2026-07-27T06:29:46.253Z","publishedAt":"2026-07-27T06:29:46.233Z","remotes":[{"id":58,"type":"streamable-http","url":"https://mcp.kajabi.com/mcp"}],"tools":[],"tags":{"data":[]},"extendsCredential":null,"icons":[{"src":"https://n8niostorageaccount.blob.core.windows.net/n8nio-strapi-blobs-prod/assets/id_BPULB_Tw_A_b4460963bc.svg","mimeType":"image/svg+xml","theme":"dark"}]}	2026-07-27 07:53:10.79+00	2026-07-27 07:53:10.79+00
lucid	active	1.0.0	2026-07-27 06:29:57.456	{"id":42,"name":"app.lucid.mcp/lucid","title":"Lucid","tagline":"Connect to the Lucid MCP Server","description":"Lucid’s connector creates diagrams, searches, edits, shares, and retrieves docs to summarize.","websiteUrl":null,"authType":"oauth2","isOfficial":true,"isPublished":true,"origin":"registry","createdAt":"2026-07-27T06:29:57.456Z","publishedAt":"2026-07-27T06:29:57.441Z","remotes":[{"id":59,"type":"streamable-http","url":"https://mcp.lucid.app/mcp"}],"tools":[],"tags":{"data":[]},"extendsCredential":null,"icons":[{"src":"https://n8niostorageaccount.blob.core.windows.net/n8nio-strapi-blobs-prod/assets/cab2c5c2_21ed_4272_8606_4ce6e117da17_b893d525b7.png","mimeType":"image/png"}]}	2026-07-27 07:53:10.79+00	2026-07-27 07:53:10.79+00
mapbox	active	0.12.7	2026-07-27 06:30:09.602	{"id":43,"name":"io.github.mapbox/mcp-server","title":"Mapbox","tagline":"Connect to the Mapbox MCP Server","description":"Geospatial intelligence with Mapbox APIs like geocoding, POI search, directions, isochrones, etc.","websiteUrl":null,"authType":"oauth2","isOfficial":true,"isPublished":true,"origin":"registry","createdAt":"2026-07-27T06:30:09.602Z","publishedAt":"2026-07-27T06:30:09.586Z","remotes":[{"id":60,"type":"streamable-http","url":"https://mcp.mapbox.com/mcp"}],"tools":[],"tags":{"data":[]},"extendsCredential":null,"icons":[{"src":"https://n8niostorageaccount.blob.core.windows.net/n8nio-strapi-blobs-prod/assets/id_Ks_p_3_Ey_088e4b1f1c.png","mimeType":"image/png","theme":"dark"}]}	2026-07-27 07:53:10.79+00	2026-07-27 07:53:10.79+00
mux	active	12.8.0	2026-07-27 06:30:21.396	{"id":44,"name":"com.mux/mcp","title":"Mux","tagline":"Connect to the Mux MCP Server","description":"The official MCP Server for the Mux API","websiteUrl":null,"authType":"oauth2","isOfficial":true,"isPublished":true,"origin":"registry","createdAt":"2026-07-27T06:30:21.396Z","publishedAt":"2026-07-27T06:30:21.382Z","remotes":[{"id":61,"type":"streamable-http","url":"https://mcp.mux.com"}],"tools":[],"tags":{"data":[]},"extendsCredential":null,"icons":[{"src":"https://n8niostorageaccount.blob.core.windows.net/n8nio-strapi-blobs-prod/assets/idd_VMK_Dr_E_9ee0d1c0fd.jpeg","mimeType":"image/jpeg","theme":"dark"}]}	2026-07-27 07:53:10.79+00	2026-07-27 07:53:10.79+00
new-relic	active	0.1.0	2026-07-27 06:30:33.181	{"id":45,"name":"com.newrelic/mcp-server","title":"New Relic","tagline":"Connect to the New Relic MCP Server","description":"Access New Relic observability data through MCP - query metrics, logs, traces, entities, and more","websiteUrl":null,"authType":"oauth2","isOfficial":true,"isPublished":true,"origin":"registry","createdAt":"2026-07-27T06:30:33.181Z","publishedAt":"2026-07-27T06:30:33.165Z","remotes":[{"id":62,"type":"streamable-http","url":"https://mcp.newrelic.com/mcp"}],"tools":[],"tags":{"data":[]},"extendsCredential":null,"icons":[{"src":"https://n8niostorageaccount.blob.core.windows.net/n8nio-strapi-blobs-prod/assets/idj_OU_5_Ls_Vn_b153d861d2.svg","mimeType":"image/svg+xml","theme":"dark"}]}	2026-07-27 07:53:10.79+00	2026-07-27 07:53:10.79+00
onlyoffice	active	3.2.0	2026-07-27 06:30:45.489	{"id":46,"name":"io.github.ONLYOFFICE/docspace","title":"Onlyoffice","tagline":"Connect to the Onlyoffice MCP Server","description":"A room-based collaborative platform","websiteUrl":null,"authType":"oauth2","isOfficial":true,"isPublished":true,"origin":"registry","createdAt":"2026-07-27T06:30:45.489Z","publishedAt":"2026-07-27T06:30:45.477Z","remotes":[{"id":63,"type":"sse","url":"https://mcp.onlyoffice.com/sse"},{"id":64,"type":"streamable-http","url":"https://mcp.onlyoffice.com/mcp"}],"tools":[],"tags":{"data":[]},"extendsCredential":null,"icons":[{"src":"https://n8niostorageaccount.blob.core.windows.net/n8nio-strapi-blobs-prod/assets/idc_J_Gf_Mm1x_3abc6daf5a.jpeg","mimeType":"image/jpeg","theme":"dark"}]}	2026-07-27 07:53:10.79+00	2026-07-27 07:53:10.79+00
open-video	active	1.1.0	2026-07-27 06:30:57.197	{"id":47,"name":"video.open/open-video","title":"Open Video","tagline":"Connect to the Open Video MCP Server","description":"AI-powered video publishing, channel management, and monetization via open.video","websiteUrl":null,"authType":"oauth2","isOfficial":true,"isPublished":true,"origin":"registry","createdAt":"2026-07-27T06:30:57.197Z","publishedAt":"2026-07-27T06:30:57.182Z","remotes":[{"id":65,"type":"streamable-http","url":"https://mcp.open.video/mcp"}],"tools":[],"tags":{"data":[]},"extendsCredential":null,"icons":[{"src":"https://n8niostorageaccount.blob.core.windows.net/n8nio-strapi-blobs-prod/assets/id_C4_Z_Er2jl_efcb489bf4.jpeg","mimeType":"image/jpeg","theme":"dark"}]}	2026-07-27 07:53:10.79+00	2026-07-27 07:53:10.79+00
open-agenda	active	1.3.2	2026-07-27 06:31:08.655	{"id":48,"name":"com.openagenda/mcp","title":"OpenAgenda","tagline":"Connect to the OpenAgenda MCP Server","description":"Search, analyze and manage events on OpenAgenda.","websiteUrl":null,"authType":"oauth2","isOfficial":true,"isPublished":true,"origin":"registry","createdAt":"2026-07-27T06:31:08.655Z","publishedAt":"2026-07-27T06:31:08.639Z","remotes":[{"id":66,"type":"streamable-http","url":"https://mcp.openagenda.com/mcp"}],"tools":[],"tags":{"data":[]},"extendsCredential":null,"icons":[{"src":"https://n8niostorageaccount.blob.core.windows.net/n8nio-strapi-blobs-prod/assets/openagenda_icon_512_white_abac3fef40.png","mimeType":"image/png"},{"src":"https://n8niostorageaccount.blob.core.windows.net/n8nio-strapi-blobs-prod/assets/openagenda_icon_white_463b7b7aad.svg","mimeType":"image/svg+xml"}]}	2026-07-27 07:53:10.79+00	2026-07-27 07:53:10.79+00
quicknode	active	1.0.0	2026-07-27 06:31:22.594	{"id":49,"name":"io.github.quicknode/mcp","title":"Quicknode","tagline":"Connect to the Quicknode MCP Server","description":"Manage your blockchain infrastructure across 80+ chains with your agents.","websiteUrl":null,"authType":"oauth2","isOfficial":true,"isPublished":true,"origin":"registry","createdAt":"2026-07-27T06:31:22.594Z","publishedAt":"2026-07-27T06:31:22.570Z","remotes":[{"id":67,"type":"streamable-http","url":"https://mcp.quicknode.com/mcp"}],"tools":[],"tags":{"data":[]},"extendsCredential":null,"icons":[{"src":"https://n8niostorageaccount.blob.core.windows.net/n8nio-strapi-blobs-prod/assets/id_Gkd_Tc_T_Q_6cd067aa96.svg","mimeType":"image/svg+xml","theme":"light"},{"src":"https://n8niostorageaccount.blob.core.windows.net/n8nio-strapi-blobs-prod/assets/id_Eo_Rfmv8_I_b2228a7aa7.svg","mimeType":"image/svg+xml","theme":"dark"}]}	2026-07-27 07:53:10.79+00	2026-07-27 07:53:10.79+00
railway	active	1.0.0	2026-07-27 06:31:34.656	{"id":50,"name":"com.railway/mcp","title":"Railway","tagline":"Connect to the Railway MCP Server","description":"Develop, manage, and debug Railway projects, services, and deployments from within agents.","websiteUrl":null,"authType":"oauth2","isOfficial":true,"isPublished":true,"origin":"registry","createdAt":"2026-07-27T06:31:34.656Z","publishedAt":"2026-07-27T06:31:34.632Z","remotes":[{"id":68,"type":"streamable-http","url":"https://mcp.railway.com/"}],"tools":[],"tags":{"data":[]},"extendsCredential":null,"icons":[{"src":"https://n8niostorageaccount.blob.core.windows.net/n8nio-strapi-blobs-prod/assets/id_N_Pa1_W_g_1b0b09d3c0.svg","mimeType":"image/svg+xml","theme":"light"},{"src":"https://n8niostorageaccount.blob.core.windows.net/n8nio-strapi-blobs-prod/assets/id_Nf_YM_Ddf_P_d0762ab2e7.svg","mimeType":"image/svg+xml","theme":"dark"}]}	2026-07-27 07:53:10.79+00	2026-07-27 07:53:10.79+00
roboflow-official	active	1.0.3	2026-07-27 06:31:46.505	{"id":51,"name":"com.roboflow/roboflow-mcp","title":"Roboflow (Official)","tagline":"Connect to the Roboflow (Official) MCP Server","description":"Roboflow computer vision for AI agents: datasets, annotation, versioning, workflows, inference.","websiteUrl":null,"authType":"oauth2","isOfficial":true,"isPublished":true,"origin":"registry","createdAt":"2026-07-27T06:31:46.505Z","publishedAt":"2026-07-27T06:31:46.487Z","remotes":[{"id":69,"type":"streamable-http","url":"https://mcp.roboflow.com/mcp"}],"tools":[],"tags":{"data":[]},"extendsCredential":null,"icons":[{"src":"https://n8niostorageaccount.blob.core.windows.net/n8nio-strapi-blobs-prod/assets/icon_5a61ee5b18.png","mimeType":"image/png"}]}	2026-07-27 07:53:10.79+00	2026-07-27 07:53:10.79+00
serpstat	active	1.1.5	2026-07-27 06:31:58.494	{"id":52,"name":"com.serpstat/mcp","title":"Serpstat","tagline":"Connect to the Serpstat MCP Server","description":"Automate your daily SEO tasks and get results in a few seconds with Serpstat SEO Tools MCP","websiteUrl":null,"authType":"oauth2","isOfficial":true,"isPublished":true,"origin":"registry","createdAt":"2026-07-27T06:31:58.494Z","publishedAt":"2026-07-27T06:31:58.473Z","remotes":[{"id":70,"type":"streamable-http","url":"https://mcp.serpstat.com/mcp"}],"tools":[],"tags":{"data":[]},"extendsCredential":null,"icons":[{"src":"https://n8niostorageaccount.blob.core.windows.net/n8nio-strapi-blobs-prod/assets/favicon_32x32_9deb9e3426.png","mimeType":"image/png"},{"src":"https://n8niostorageaccount.blob.core.windows.net/n8nio-strapi-blobs-prod/assets/favicon_16x16_978f8c1d24.png","mimeType":"image/png"},{"src":"https://n8niostorageaccount.blob.core.windows.net/n8nio-strapi-blobs-prod/assets/apple_touch_icon_60x60_0e141e6ab3.png","mimeType":"image/png"},{"src":"https://n8niostorageaccount.blob.core.windows.net/n8nio-strapi-blobs-prod/assets/apple_touch_icon_120x120_989cf97cef.png","mimeType":"image/png"},{"src":"https://n8niostorageaccount.blob.core.windows.net/n8nio-strapi-blobs-prod/assets/mstile_144x144_86f983426c.png","mimeType":"image/png"},{"src":"https://n8niostorageaccount.blob.core.windows.net/n8nio-strapi-blobs-prod/assets/apple_touch_icon_180x180_d5650b553b.png","mimeType":"image/png"}]}	2026-07-27 07:53:10.79+00	2026-07-27 07:53:10.79+00
tenderly	active	1.0.1	2026-07-27 06:32:10.706	{"id":53,"name":"co.tenderly/tenderly-mcp","title":"Tenderly","tagline":"Connect to the Tenderly MCP Server","description":"Tenderly MCP server for blockchain dev — simulate, debug, and test on 100+ networks.","websiteUrl":null,"authType":"oauth2","isOfficial":true,"isPublished":true,"origin":"registry","createdAt":"2026-07-27T06:32:10.706Z","publishedAt":"2026-07-27T06:32:10.680Z","remotes":[{"id":71,"type":"streamable-http","url":"https://mcp.tenderly.co/mcp"}],"tools":[],"tags":{"data":[]},"extendsCredential":null,"icons":[{"src":"https://n8niostorageaccount.blob.core.windows.net/n8nio-strapi-blobs-prod/assets/id_Np_P91btg_2999d326fa.svg","mimeType":"image/svg+xml","theme":"light"},{"src":"https://n8niostorageaccount.blob.core.windows.net/n8nio-strapi-blobs-prod/assets/idg5pc_CT_Me_199bebd567.svg","mimeType":"image/svg+xml","theme":"dark"}]}	2026-07-27 07:53:10.79+00	2026-07-27 07:53:10.79+00
user-guiding	active	1.0.0	2026-07-27 06:32:22.58	{"id":54,"name":"io.github.userguiding/mcp","title":"UserGuiding","tagline":"Connect to the UserGuiding MCP Server","description":"Manage users, track events, companies, and knowledge base articles in UserGuiding.","websiteUrl":null,"authType":"oauth2","isOfficial":true,"isPublished":true,"origin":"registry","createdAt":"2026-07-27T06:32:22.580Z","publishedAt":"2026-07-27T06:32:22.566Z","remotes":[{"id":72,"type":"streamable-http","url":"https://mcp.userguiding.com/mcp/"}],"tools":[],"tags":{"data":[]},"extendsCredential":null,"icons":[{"src":"https://n8niostorageaccount.blob.core.windows.net/n8nio-strapi-blobs-prod/assets/id_Gqzc_El_EH_ac5ec7c6bf.jpeg","mimeType":"image/jpeg","theme":"dark"}]}	2026-07-27 07:53:10.79+00	2026-07-27 07:53:10.79+00
wordlift	active	1.0.7	2026-07-27 06:32:34.408	{"id":55,"name":"io.wordlift/mcp-server","title":"Wordlift","tagline":"Connect to the Wordlift MCP Server","description":"Knowledge Graph, GraphQL, GS1 Digital Link and SEO tools for semantic content optimization.","websiteUrl":null,"authType":"oauth2","isOfficial":true,"isPublished":true,"origin":"registry","createdAt":"2026-07-27T06:32:34.408Z","publishedAt":"2026-07-27T06:32:34.385Z","remotes":[{"id":73,"type":"sse","url":"https://mcp.wordlift.io/sse"}],"tools":[],"tags":{"data":[]},"extendsCredential":null,"icons":[{"src":"https://n8niostorageaccount.blob.core.windows.net/n8nio-strapi-blobs-prod/assets/id_Y8_Nf90og_3c8f9dbd0a.png","mimeType":"image/png","theme":"dark"}]}	2026-07-27 07:53:10.79+00	2026-07-27 07:53:10.79+00
zigpoll	active	2.0.0	2026-07-27 06:32:46.428	{"id":56,"name":"com.zigpoll/zigpoll-mcp","title":"Zigpoll","tagline":"Connect to the Zigpoll MCP Server","description":"Analyze Zigpoll survey responses, track trends, and get AI-powered insights.","websiteUrl":null,"authType":"oauth2","isOfficial":true,"isPublished":true,"origin":"registry","createdAt":"2026-07-27T06:32:46.428Z","publishedAt":"2026-07-27T06:32:46.415Z","remotes":[{"id":74,"type":"streamable-http","url":"https://mcp.zigpoll.com/mcp"}],"tools":[],"tags":{"data":[]},"extendsCredential":null,"icons":[{"src":"https://n8niostorageaccount.blob.core.windows.net/n8nio-strapi-blobs-prod/assets/id_b4l_E3_VQ_6438fbc3e9.jpeg","mimeType":"image/jpeg","theme":"dark"}]}	2026-07-27 07:53:10.79+00	2026-07-27 07:53:10.79+00
ivisa	active	0.0.3	2026-07-27 06:32:58.532	{"id":57,"name":"com.ivisa.www/mcp","title":"Ivisa","tagline":"Connect to the Ivisa MCP Server","description":"Check visa requirements and travel documents for international travel destinations.","websiteUrl":null,"authType":"oauth2","isOfficial":true,"isPublished":true,"origin":"registry","createdAt":"2026-07-27T06:32:58.532Z","publishedAt":"2026-07-27T06:32:58.503Z","remotes":[{"id":75,"type":"streamable-http","url":"https://www.ivisa.com/mcp"},{"id":76,"type":"sse","url":"https://www.ivisa.com/mcp"}],"tools":[],"tags":{"data":[]},"extendsCredential":null,"icons":[{"src":"https://n8niostorageaccount.blob.core.windows.net/n8nio-strapi-blobs-prod/assets/id_Go_Qi_Xix_P_239207701b.jpeg","mimeType":"image/jpeg","theme":"dark"}]}	2026-07-27 07:53:10.79+00	2026-07-27 07:53:10.79+00
veed-ai-video-generator	active	1.0.0	2026-07-27 06:33:09.725	{"id":58,"name":"io.veed/fabric-mcp","title":"VEED AI Video Generator","tagline":"Connect to the VEED AI Video Generator MCP Server","description":"Generate AI talking-head videos with custom characters and voices.","websiteUrl":null,"authType":"oauth2","isOfficial":true,"isPublished":true,"origin":"registry","createdAt":"2026-07-27T06:33:09.725Z","publishedAt":"2026-07-27T06:33:09.706Z","remotes":[{"id":77,"type":"streamable-http","url":"https://www.veed.io/api/v1/mcp"}],"tools":[],"tags":{"data":[]},"extendsCredential":null,"icons":[{"src":"https://n8niostorageaccount.blob.core.windows.net/n8nio-strapi-blobs-prod/assets/favicon_prod_d15545bdfc.svg","mimeType":"image/svg+xml"},{"src":"https://n8niostorageaccount.blob.core.windows.net/n8nio-strapi-blobs-prod/assets/favicon_32x32_f264fbd0f8.png","mimeType":"image/png"}]}	2026-07-27 07:53:10.79+00	2026-07-27 07:53:10.79+00
fingerprint	active	0.1.35	2026-07-27 06:33:21.382	{"id":59,"name":"io.github.fingerprintjs/fingerprint-mcp-server","title":"Fingerprint","tagline":"Connect to the Fingerprint MCP Server","description":"Device intelligence for AI agents: Fingerprint events, smart signals, and API key management.","websiteUrl":null,"authType":"oauth2","isOfficial":true,"isPublished":true,"origin":"registry","createdAt":"2026-07-27T06:33:21.382Z","publishedAt":"2026-07-27T06:33:21.372Z","remotes":[{"id":78,"type":"streamable-http","url":"https://mcp.fpjs.io/mcp"}],"tools":[],"tags":{"data":[]},"extendsCredential":null,"icons":[{"src":"https://n8niostorageaccount.blob.core.windows.net/n8nio-strapi-blobs-prod/assets/id7_Fxo_YI_61_3ef3687cce.png","mimeType":"image/png","theme":"dark"}]}	2026-07-27 07:53:10.79+00	2026-07-27 07:53:10.79+00
altmetric	active	1.1.0	2026-07-27 06:33:32.848	{"id":60,"name":"com.altmetric.mcp/altmetric-mcp","title":"Altmetric","tagline":"Connect to the Altmetric MCP Server","description":"MCP server for Altmetric APIs - track research attention across news, policy, social media, and more","websiteUrl":null,"authType":"oauth2","isOfficial":true,"isPublished":true,"origin":"registry","createdAt":"2026-07-27T06:33:32.848Z","publishedAt":"2026-07-27T06:33:32.831Z","remotes":[{"id":79,"type":"streamable-http","url":"https://mcp.altmetric.com/mcp"}],"tools":[],"tags":{"data":[]},"extendsCredential":null,"icons":[{"src":"https://n8niostorageaccount.blob.core.windows.net/n8nio-strapi-blobs-prod/assets/icon_50fcccdb0a.svg","mimeType":"image/svg+xml"}]}	2026-07-27 07:53:10.79+00	2026-07-27 07:53:10.79+00
brandfetch	active	1.0.1	2026-07-27 06:33:44.412	{"id":61,"name":"io.brandfetch/brandfetch","title":"Brandfetch","tagline":"Connect to the Brandfetch MCP Server","description":"Search brands and retrieve design assets, company data, other brand context from Brandfetch's API","websiteUrl":null,"authType":"oauth2","isOfficial":true,"isPublished":true,"origin":"registry","createdAt":"2026-07-27T06:33:44.412Z","publishedAt":"2026-07-27T06:33:44.395Z","remotes":[{"id":80,"type":"streamable-http","url":"https://mcp.brandfetch.io/mcp"}],"tools":[],"tags":{"data":[]},"extendsCredential":null,"icons":[{"src":"https://n8niostorageaccount.blob.core.windows.net/n8nio-strapi-blobs-prod/assets/id_X_Gq6_S_Iu2_39f64c1e3e.svg","mimeType":"image/svg+xml","theme":"light"},{"src":"https://n8niostorageaccount.blob.core.windows.net/n8nio-strapi-blobs-prod/assets/idd_CQ_52_AR_5_a0d0556d83.svg","mimeType":"image/svg+xml","theme":"dark"}]}	2026-07-27 07:53:10.79+00	2026-07-27 07:53:10.79+00
cello	active	1.0.1	2026-07-27 06:33:55.459	{"id":62,"name":"so.cello/mcp","title":"Cello","tagline":"Connect to the Cello MCP Server","description":"Cello MCP server to launch and manage your Referral and Partner program","websiteUrl":null,"authType":"oauth2","isOfficial":true,"isPublished":true,"origin":"registry","createdAt":"2026-07-27T06:33:55.459Z","publishedAt":"2026-07-27T06:33:55.441Z","remotes":[{"id":81,"type":"streamable-http","url":"https://mcp.cello.so/mcp"}],"tools":[],"tags":{"data":[]},"extendsCredential":null,"icons":[{"src":"https://n8niostorageaccount.blob.core.windows.net/n8nio-strapi-blobs-prod/assets/icon_48x48_f037a7c241.png","mimeType":"image/png"}]}	2026-07-27 07:53:10.79+00	2026-07-27 07:53:10.79+00
composio	active	1.0.5	2026-07-27 06:34:06.747	{"id":63,"name":"io.github.ComposioHQ/composio","title":"Composio","tagline":"Connect to the Composio MCP Server","description":"Connect AI agents to 1000+ apps with managed authentication and tool-calling.","websiteUrl":null,"authType":"oauth2","isOfficial":true,"isPublished":true,"origin":"registry","createdAt":"2026-07-27T06:34:06.747Z","publishedAt":"2026-07-27T06:34:06.652Z","remotes":[{"id":82,"type":"streamable-http","url":"https://connect.composio.dev/mcp"}],"tools":[],"tags":{"data":[]},"extendsCredential":null,"icons":[{"src":"https://n8niostorageaccount.blob.core.windows.net/n8nio-strapi-blobs-prod/assets/Logomark_Black_fe5c6c91c6.svg","mimeType":"image/svg+xml","theme":"light"},{"src":"https://n8niostorageaccount.blob.core.windows.net/n8nio-strapi-blobs-prod/assets/Logomark_White_b349b06097.svg","mimeType":"image/svg+xml","theme":"dark"}]}	2026-07-27 07:53:10.79+00	2026-07-27 07:53:10.79+00
gtmetrix	active	1.1.0	2026-07-27 06:34:18.943	{"id":64,"name":"com.gtmetrix/gtmetrix","title":"Gtmetrix","tagline":"Connect to the Gtmetrix MCP Server","description":"Analyze web performance and get optimization insights from GTmetrix, directly in your AI workflow.","websiteUrl":null,"authType":"oauth2","isOfficial":true,"isPublished":true,"origin":"registry","createdAt":"2026-07-27T06:34:18.943Z","publishedAt":"2026-07-27T06:34:18.929Z","remotes":[{"id":83,"type":"streamable-http","url":"https://gtmetrix.com/mcp"}],"tools":[],"tags":{"data":[]},"extendsCredential":null,"icons":[{"src":"https://n8niostorageaccount.blob.core.windows.net/n8nio-strapi-blobs-prod/assets/id_S5_Ofsvh_D_030852542c.jpeg","mimeType":"image/jpeg","theme":"dark"}]}	2026-07-27 07:53:10.79+00	2026-07-27 07:53:10.79+00
lusha	active	1.0.0	2026-07-27 06:34:30.787	{"id":65,"name":"com.lusha.mcp/mcp","title":"Lusha","tagline":"Connect to the Lusha MCP Server","description":"Lusha MCP server for authorized business profile, usage, and buying-signal insights.","websiteUrl":null,"authType":"oauth2","isOfficial":true,"isPublished":true,"origin":"registry","createdAt":"2026-07-27T06:34:30.787Z","publishedAt":"2026-07-27T06:34:30.767Z","remotes":[{"id":84,"type":"streamable-http","url":"https://mcp.lusha.com/mcp"}],"tools":[],"tags":{"data":[]},"extendsCredential":null,"icons":[{"src":"https://n8niostorageaccount.blob.core.windows.net/n8nio-strapi-blobs-prod/assets/id_Oqhne_W4l_160b2c6387.svg","mimeType":"image/svg+xml","theme":"light"},{"src":"https://n8niostorageaccount.blob.core.windows.net/n8nio-strapi-blobs-prod/assets/id_Hn_Bv_Pm_MF_b3cab3545f.svg","mimeType":"image/svg+xml","theme":"dark"}]}	2026-07-27 07:53:10.79+00	2026-07-27 07:53:10.79+00
opus-clip	active	0.1.2	2026-07-27 06:34:42.641	{"id":66,"name":"io.github.opus-pro/opusclip","title":"OpusClip","tagline":"Connect to the OpusClip MCP Server","description":"Turn long videos into AI-curated short clips: caption, reframe, thumbnail, schedule, and publish.","websiteUrl":null,"authType":"oauth2","isOfficial":true,"isPublished":true,"origin":"registry","createdAt":"2026-07-27T06:34:42.641Z","publishedAt":"2026-07-27T06:34:42.627Z","remotes":[{"id":85,"type":"streamable-http","url":"https://mcp.opus.pro/mcp"}],"tools":[],"tags":{"data":[]},"extendsCredential":null,"icons":[{"src":"https://n8niostorageaccount.blob.core.windows.net/n8nio-strapi-blobs-prod/assets/id16btw_Mn_34285031cd.jpeg","mimeType":"image/jpeg","theme":"dark"}]}	2026-07-27 07:53:10.79+00	2026-07-27 07:53:10.79+00
rackspace-spot	active	0.3.2	2026-07-27 06:34:54.483	{"id":67,"name":"io.github.rackspace-spot/spot-mcp","title":"Rackspace Spot","tagline":"Connect to the Rackspace Spot MCP Server","description":"Manage Rackspace Spot Kubernetes Cloudspaces, node pools, and VMs from your AI assistant.","websiteUrl":null,"authType":"oauth2","isOfficial":true,"isPublished":true,"origin":"registry","createdAt":"2026-07-27T06:34:54.483Z","publishedAt":"2026-07-27T06:34:54.469Z","remotes":[{"id":86,"type":"streamable-http","url":"https://mcp.spot.rackspace.com/mcp"}],"tools":[],"tags":{"data":[]},"extendsCredential":null,"icons":[{"src":"https://n8niostorageaccount.blob.core.windows.net/n8nio-strapi-blobs-prod/assets/id_R_Am_XHO_Xj_c7492988ea.jpeg","mimeType":"image/jpeg","theme":"dark"}]}	2026-07-27 07:53:10.79+00	2026-07-27 07:53:10.79+00
send-pulse	active	1.0.0	2026-07-27 06:35:06.234	{"id":68,"name":"com.sendpulse.mcp/mcp-server","title":"SendPulse","tagline":"Connect to the SendPulse MCP Server","description":"Empower AI agents with SendPulse email, CRM, chatbot, SMTP, and course automation","websiteUrl":null,"authType":"oauth2","isOfficial":true,"isPublished":true,"origin":"registry","createdAt":"2026-07-27T06:35:06.234Z","publishedAt":"2026-07-27T06:35:06.215Z","remotes":[{"id":87,"type":"streamable-http","url":"https://mcp.sendpulse.com/mcp"}],"tools":[],"tags":{"data":[]},"extendsCredential":null,"icons":[{"src":"https://n8niostorageaccount.blob.core.windows.net/n8nio-strapi-blobs-prod/assets/idv4t5t_Kt_Q_bad208ede1.jpeg","mimeType":"image/jpeg","theme":"dark"}]}	2026-07-27 07:53:10.79+00	2026-07-27 07:53:10.79+00
snitcher	active	1.1.0	2026-07-27 06:35:18.252	{"id":69,"name":"com.snitcher/snitcher","title":"Snitcher","tagline":"Connect to the Snitcher MCP Server","description":"Identify companies visiting your website: organisations, contacts, segments, tags, CRM sync.","websiteUrl":null,"authType":"oauth2","isOfficial":true,"isPublished":true,"origin":"registry","createdAt":"2026-07-27T06:35:18.252Z","publishedAt":"2026-07-27T06:35:18.236Z","remotes":[{"id":88,"type":"streamable-http","url":"https://app.snitcher.com/mcp/snitcher"}],"tools":[],"tags":{"data":[]},"extendsCredential":null,"icons":[{"src":"https://n8niostorageaccount.blob.core.windows.net/n8nio-strapi-blobs-prod/assets/idgwm_NEV_1_f421fc6c44.svg","mimeType":"image/svg+xml","theme":"dark"}]}	2026-07-27 07:53:10.79+00	2026-07-27 07:53:10.79+00
\.


--
-- Data for Name: instance_ai_mcp_registry_connections; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."instance_ai_mcp_registry_connections" ("id", "credentialId", "serverSlug", "toolFilter", "userId", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: instance_ai_messages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."instance_ai_messages" ("id", "threadId", "content", "role", "type", "resourceId", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: instance_ai_observation_cursors; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."instance_ai_observation_cursors" ("observationScopeId", "lastObservedMessageId", "lastObservedAt", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: instance_ai_observation_locks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."instance_ai_observation_locks" ("observationScopeId", "taskKind", "holderId", "heldUntil", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: instance_ai_observational_memory; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."instance_ai_observational_memory" ("id", "lookupKey", "scope", "threadId", "resourceId", "activeObservations", "originType", "config", "generationCount", "lastObservedAt", "pendingMessageTokens", "totalTokensObserved", "observationTokenCount", "isObserving", "isReflecting", "observedMessageIds", "observedTimezone", "bufferedObservations", "bufferedObservationTokens", "bufferedMessageIds", "bufferedReflection", "bufferedReflectionTokens", "bufferedReflectionInputTokens", "reflectedObservationLineCount", "bufferedObservationChunks", "isBufferingObservation", "isBufferingReflection", "lastBufferedAtTokens", "lastBufferedAtTime", "metadata", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: instance_ai_observations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."instance_ai_observations" ("id", "observationScopeId", "marker", "text", "parentId", "tokenCount", "status", "supersededBy", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: instance_ai_pending_confirmations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."instance_ai_pending_confirmations" ("requestId", "threadId", "userId", "kind", "runId", "toolCallId", "messageGroupId", "checkpointKey", "checkpointTaskId", "expiresAt", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: instance_ai_resources; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."instance_ai_resources" ("id", "workingMemory", "metadata", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: instance_ai_run_snapshots; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."instance_ai_run_snapshots" ("threadId", "runId", "messageGroupId", "runIds", "tree", "createdAt", "updatedAt", "langsmithRunId", "langsmithTraceId", "traceId", "spanId") FROM stdin;
\.


--
-- Data for Name: instance_ai_thread_grants; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."instance_ai_thread_grants" ("threadId", "userId", "grantKey", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: instance_ai_workflow_snapshots; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."instance_ai_workflow_snapshots" ("runId", "workflowName", "resourceId", "status", "snapshot", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: instance_version_history; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."instance_version_history" ("id", "major", "minor", "patch", "createdAt") FROM stdin;
1	2	31	6	2026-07-25 07:53:02.964+00
\.


--
-- Data for Name: invalid_auth_token; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."invalid_auth_token" ("token", "expiresAt") FROM stdin;
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."migrations" ("id", "timestamp", "name") FROM stdin;
1	1587669153312	InitialMigration1587669153312
2	1589476000887	WebhookModel1589476000887
3	1594828256133	CreateIndexStoppedAt1594828256133
4	1607431743768	MakeStoppedAtNullable1607431743768
5	1611144599516	AddWebhookId1611144599516
6	1617270242566	CreateTagEntity1617270242566
7	1620824779533	UniqueWorkflowNames1620824779533
8	1626176912946	AddwaitTill1626176912946
9	1630419189837	UpdateWorkflowCredentials1630419189837
10	1644422880309	AddExecutionEntityIndexes1644422880309
11	1646834195327	IncreaseTypeVarcharLimit1646834195327
12	1646992772331	CreateUserManagement1646992772331
13	1648740597343	LowerCaseUserEmail1648740597343
14	1652254514002	CommunityNodes1652254514002
15	1652367743993	AddUserSettings1652367743993
16	1652905585850	AddAPIKeyColumn1652905585850
17	1654090467022	IntroducePinData1654090467022
18	1658932090381	AddNodeIds1658932090381
19	1659902242948	AddJsonKeyPinData1659902242948
20	1660062385367	CreateCredentialsUserRole1660062385367
21	1663755770893	CreateWorkflowsEditorRole1663755770893
22	1664196174001	WorkflowStatistics1664196174001
23	1665484192212	CreateCredentialUsageTable1665484192212
24	1665754637025	RemoveCredentialUsageTable1665754637025
25	1669739707126	AddWorkflowVersionIdColumn1669739707126
26	1669823906995	AddTriggerCountColumn1669823906995
27	1671535397530	MessageEventBusDestinations1671535397530
28	1671726148421	RemoveWorkflowDataLoadedFlag1671726148421
29	1673268682475	DeleteExecutionsWithWorkflows1673268682475
30	1674138566000	AddStatusToExecutions1674138566000
31	1674509946020	CreateLdapEntities1674509946020
32	1675940580449	PurgeInvalidWorkflowConnections1675940580449
33	1676996103000	MigrateExecutionStatus1676996103000
34	1677236854063	UpdateRunningExecutionStatus1677236854063
35	1677501636754	CreateVariables1677501636754
36	1679416281778	CreateExecutionMetadataTable1679416281778
37	1681134145996	AddUserActivatedProperty1681134145996
38	1681134145997	RemoveSkipOwnerSetup1681134145997
39	1690000000000	MigrateIntegerKeysToString1690000000000
40	1690000000020	SeparateExecutionData1690000000020
41	1690000000030	RemoveResetPasswordColumns1690000000030
42	1690000000030	AddMfaColumns1690000000030
43	1690787606731	AddMissingPrimaryKeyOnExecutionData1690787606731
44	1691088862123	CreateWorkflowNameIndex1691088862123
45	1692967111175	CreateWorkflowHistoryTable1692967111175
46	1693491613982	ExecutionSoftDelete1693491613982
47	1693554410387	DisallowOrphanExecutions1693554410387
48	1694091729095	MigrateToTimestampTz1694091729095
49	1695128658538	AddWorkflowMetadata1695128658538
50	1695829275184	ModifyWorkflowHistoryNodesAndConnections1695829275184
51	1700571993961	AddGlobalAdminRole1700571993961
52	1705429061930	DropRoleMapping1705429061930
53	1711018413374	RemoveFailedExecutionStatus1711018413374
54	1711390882123	MoveSshKeysToDatabase1711390882123
55	1712044305787	RemoveNodesAccess1712044305787
56	1714133768519	CreateProject1714133768519
57	1714133768521	MakeExecutionStatusNonNullable1714133768521
58	1717498465931	AddActivatedAtUserSetting1717498465931
59	1720101653148	AddConstraintToExecutionMetadata1720101653148
60	1721377157740	FixExecutionMetadataSequence1721377157740
61	1723627610222	CreateInvalidAuthTokenTable1723627610222
62	1723796243146	RefactorExecutionIndices1723796243146
63	1724753530828	CreateAnnotationTables1724753530828
64	1724951148974	AddApiKeysTable1724951148974
65	1726606152711	CreateProcessedDataTable1726606152711
66	1727427440136	SeparateExecutionCreationFromStart1727427440136
67	1728659839644	AddMissingPrimaryKeyOnAnnotationTagMapping1728659839644
68	1729607673464	UpdateProcessedDataValueColumnToText1729607673464
69	1729607673469	AddProjectIcons1729607673469
70	1730386903556	CreateTestDefinitionTable1730386903556
71	1731404028106	AddDescriptionToTestDefinition1731404028106
72	1731582748663	MigrateTestDefinitionKeyToString1731582748663
73	1732271325258	CreateTestMetricTable1732271325258
74	1732549866705	CreateTestRun1732549866705
75	1733133775640	AddMockedNodesColumnToTestDefinition1733133775640
76	1734479635324	AddManagedColumnToCredentialsTable1734479635324
77	1736172058779	AddStatsColumnsToTestRun1736172058779
78	1736947513045	CreateTestCaseExecutionTable1736947513045
79	1737715421462	AddErrorColumnsToTestRuns1737715421462
80	1738709609940	CreateFolderTable1738709609940
81	1739549398681	CreateAnalyticsTables1739549398681
82	1740445074052	UpdateParentFolderIdColumn1740445074052
83	1741167584277	RenameAnalyticsToInsights1741167584277
84	1742918400000	AddScopesColumnToApiKeys1742918400000
85	1745322634000	ClearEvaluation1745322634000
86	1745587087521	AddWorkflowStatisticsRootCount1745587087521
87	1745934666076	AddWorkflowArchivedColumn1745934666076
88	1745934666077	DropRoleTable1745934666077
89	1747824239000	AddProjectDescriptionColumn1747824239000
90	1750252139166	AddLastActiveAtColumnToUser1750252139166
91	1750252139166	AddScopeTables1750252139166
92	1750252139167	AddRolesTables1750252139167
93	1750252139168	LinkRoleToUserTable1750252139168
94	1750252139170	RemoveOldRoleColumn1750252139170
95	1752669793000	AddInputsOutputsToTestCaseExecution1752669793000
96	1753953244168	LinkRoleToProjectRelationTable1753953244168
97	1754475614601	CreateDataStoreTables1754475614601
98	1754475614602	ReplaceDataStoreTablesWithDataTables1754475614602
99	1756906557570	AddTimestampsToRoleAndRoleIndexes1756906557570
100	1758731786132	AddAudienceColumnToApiKeys1758731786132
101	1758794506893	AddProjectIdToVariableTable1758794506893
102	1759399811000	ChangeValueTypesForInsights1759399811000
103	1760019379982	CreateChatHubTables1760019379982
104	1760020000000	CreateChatHubAgentTable1760020000000
105	1760020838000	UniqueRoleNames1760020838000
106	1760116750277	CreateOAuthEntities1760116750277
107	1760314000000	CreateWorkflowDependencyTable1760314000000
108	1760965142113	DropUnusedChatHubColumns1760965142113
109	1761047826451	AddWorkflowVersionColumn1761047826451
110	1761655473000	ChangeDependencyInfoToJson1761655473000
111	1761773155024	AddAttachmentsToChatHubMessages1761773155024
112	1761830340990	AddToolsColumnToChatHubTables1761830340990
113	1762177736257	AddWorkflowDescriptionColumn1762177736257
114	1762763704614	BackfillMissingWorkflowHistoryRecords1762763704614
115	1762771264000	ChangeDefaultForIdInUserTable1762771264000
116	1762771954619	AddIsGlobalColumnToCredentialsTable1762771954619
117	1762847206508	AddWorkflowHistoryAutoSaveFields1762847206508
118	1763047800000	AddActiveVersionIdColumn1763047800000
119	1763048000000	ActivateExecuteWorkflowTriggerWorkflows1763048000000
120	1763572724000	ChangeOAuthStateColumnToUnboundedVarchar1763572724000
121	1763716655000	CreateBinaryDataTable1763716655000
122	1764167920585	CreateWorkflowPublishHistoryTable1764167920585
123	1764276827837	AddCreatorIdToProjectTable1764276827837
124	1764682447000	CreateDynamicCredentialResolverTable1764682447000
125	1764689388394	AddDynamicCredentialEntryTable1764689388394
126	1765448186933	BackfillMissingWorkflowHistoryRecords1765448186933
127	1765459448000	AddResolvableFieldsToCredentials1765459448000
128	1765788427674	AddIconToAgentTable1765788427674
129	1765804780000	ConvertAgentIdToUuid1765804780000
130	1765886667897	AddAgentIdForeignKeys1765886667897
131	1765892199653	AddWorkflowVersionIdToExecutionData1765892199653
132	1766064542000	AddWorkflowPublishScopeToProjectRoles1766064542000
133	1766068346315	AddChatMessageIndices1766068346315
134	1766500000000	ExpandInsightsWorkflowIdLength1766500000000
135	1767018516000	ChangeWorkflowStatisticsFKToNoAction1767018516000
136	1768402473068	ExpandModelColumnLength1768402473068
137	1768557000000	AddStoredAtToExecutionEntity1768557000000
138	1768901721000	AddDynamicCredentialUserEntryTable1768901721000
139	1769000000000	AddPublishedVersionIdToWorkflowDependency1769000000000
140	1769433700000	CreateSecretsProviderConnectionTables1769433700000
141	1769698710000	CreateWorkflowPublishedVersionTable1769698710000
142	1769784356000	ExpandSubjectIDColumnLength1769784356000
143	1769900001000	AddWorkflowUnpublishScopeToCustomRoles1769900001000
144	1770000000000	CreateChatHubToolsTable1770000000000
145	1770000000000	ExpandProviderIdColumnLength1770000000000
146	1770220686000	CreateWorkflowBuilderSessionTable1770220686000
147	1771417407753	AddScalingFieldsToTestRun1771417407753
148	1771500000000	MigrateExternalSecretsToEntityStorage1771500000000
149	1771500000001	AddUnshareScopeToCustomRoles1771500000001
150	1771500000002	AddFilesColumnToChatHubAgents1771500000002
151	1772000000000	AddSuggestedPromptsToAgentTable1772000000000
152	1772619247761	AddRoleColumnToProjectSecretsProviderAccess1772619247761
153	1772619247762	ChangeWorkflowPublishedVersionFKsToRestrict1772619247762
154	1772700000000	AddTypeToChatHubSessions1772700000000
155	1772800000000	CreateRoleMappingRuleTable1772800000000
156	1773000000000	CreateCredentialDependencyTable1773000000000
157	1774280963551	AddRestoreFieldsToWorkflowBuilderSession1774280963551
158	1774854660000	CreateInstanceVersionHistoryTable1774854660000
159	1775000000000	CreateInstanceAiTables1775000000000
160	1775116241000	CreateTokenExchangeJtiTable1775116241000
161	1775740765000	ChangeWorkflowPublishHistoryVersionIdToSetNull1775740765000
162	1776000000000	CreateTrustedKeyTables1776000000000
163	1776150756000	CreateFavoritesTable1776150756000
164	1777000000000	CreateDeploymentKeyTable1777000000000
165	1777023444000	AddJweKeyIndexesToDeploymentKey1777023444000
166	1777045000000	AddTracingContextToExecution1777045000000
167	1777100000000	AddLangsmithIdsToInstanceAiRunSnapshots1777100000000
168	1777281990043	CreateAiBuilderTemporaryWorkflowTable1777281990043
169	1777420800000	ExpandVariablesValueColumnToText1777420800000
170	1777996709110	AddRunIndexToTestCaseExecution1777996709110
171	1778000000000	AddExecutionDeduplicationKey1778000000000
172	1778100000000	CreateEvaluationConfig1778100000000
173	1778100001000	AddWorkflowVersionToTestRun1778100001000
174	1778100002000	AddEvaluationConfigColumnsToTestRun1778100002000
175	1778496086558	CreateEvaluationCollection1778496086558
176	1783000000000	CreateAgentTables1783000000000
177	1783000000001	CreateAgentExecutionTables1783000000001
178	1784000000000	CreateAgentObservationTables1784000000000
179	1784000000001	ReplaceAgentObservationTables1784000000001
180	1784000000002	DropAgentExecutionWorkingMemory1784000000002
181	1784000000003	LimitWorkflowVersionTriggerToContent1784000000003
182	1784000000004	AddInsightsRawTimestampIdIndex1784000000004
183	1784000000005	CreateMcpRegistryServerTable1784000000005
184	1784000000006	AddNodeGroupsColumnToWorkflowAndHistory1784000000006
185	1784000000007	CreateInstanceAiCheckpointTable1784000000007
186	1784000000008	ResetInstanceAiNativePersistence1784000000008
187	1784000000009	CreateAgentMemoryEntryTables1784000000009
188	1784000000010	RefactorAgentObservationScope1784000000010
189	1784000000011	CreateAgentHistoryTable1784000000011
190	1784000000012	CreateInstanceAiObservationTables1784000000012
191	1784000000013	SplitRedactionScopeInCustomRoles1784000000013
192	1784000000014	PersistInstanceAiPendingConfirmations1784000000014
193	1784000000015	AddSourceWorkflowIdToWorkflow1784000000015
194	1784000000016	UseSlugAsPrimaryKeyInMcpRegistryServer1784000000016
195	1784000000017	AddLastUsedAtToApiKey1784000000017
196	1784000000018	CreateAgentFilesTable1784000000018
197	1784000000019	AddCustomTelemetryTagsToProject1784000000019
198	1784000000021	CreateAgentTaskDefinitionTable1784000000021
199	1784000000022	AddSubAgentLinkageToAgentExecutionThreads1784000000022
200	1784000000023	CreateInstanceAiMcpRegistryConnectionTable1784000000023
201	1784000000024	AddResourceToOAuthAuthorizationCodes1784000000024
202	1784000000025	MigrateRedactionEnforcementToFloor1784000000025
203	1784000000026	AddScopeColumnToOAuthTables1784000000026
204	1784000000027	CreateWorkflowPublicationOutboxTable1784000000027
205	1784000000028	AddProjectIdToInstanceAiThread1784000000028
206	1784000000029	AddJsonSizeBytesAndWorkflowVersionIdToExecutionEntity1784000000029
207	1784000000030	CreateAgentChatSubscriptions1784000000030
208	1784000000031	AddExecutionEntityWorkflowStatusIndex1784000000031
209	1784000000033	AddBinaryDataSizeBytesToExecutionEntity1784000000033
210	1784000000034	AllowAzureStoredAt1784000000034
211	1784000000035	AddUniqueAgentFileNames1784000000035
212	1784000000036	CreateInstanceAiThreadGrantTable1784000000036
213	1784000000037	DropAgentDescriptionFromAgents1784000000037
214	1784000000038	SetChatHubEnabledFromUsage1784000000038
215	1784000000039	DropAgentExecutionFallbackColumns1784000000039
216	1784000000040	CreateWorkflowPublicationTriggerStatusTable1784000000040
217	1784000000041	AddUsedPrivateCredentialsToExecutionEntity1784000000041
218	1784000000042	CreateSchedulerTables1784000000042
219	1784000000043	CreateWorkflowStatisticsDeltaTable1784000000043
220	1784000000044	AddPartialIndexForGlobalCredentials1784000000044
221	1784000000045	AddRecurringCronScheduleKind1784000000045
222	1784000000048	AddTriggerKindToWorkflowPublicationTriggerStatus1784000000048
\.


--
-- Data for Name: oauth_clients; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."oauth_clients" ("id", "name", "redirectUris", "grantTypes", "clientSecret", "clientSecretExpiresAt", "tokenEndpointAuthMethod", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: oauth_access_tokens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."oauth_access_tokens" ("token", "clientId", "userId") FROM stdin;
\.


--
-- Data for Name: oauth_authorization_codes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."oauth_authorization_codes" ("code", "clientId", "userId", "redirectUri", "codeChallenge", "codeChallengeMethod", "expiresAt", "state", "used", "createdAt", "updatedAt", "resource", "scope") FROM stdin;
\.


--
-- Data for Name: oauth_refresh_tokens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."oauth_refresh_tokens" ("token", "clientId", "userId", "expiresAt", "createdAt", "updatedAt", "scope") FROM stdin;
\.


--
-- Data for Name: oauth_user_consents; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."oauth_user_consents" ("id", "userId", "clientId", "grantedAt") FROM stdin;
\.


--
-- Data for Name: processed_data; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."processed_data" ("workflowId", "context", "createdAt", "updatedAt", "value") FROM stdin;
\.


--
-- Data for Name: project_relation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."project_relation" ("projectId", "userId", "role", "createdAt", "updatedAt") FROM stdin;
mZfC7A4PSYI9o6Vm	d661e0bc-24f7-4347-a9ad-ba60de14eecb	project:personalOwner	2026-07-25 07:45:39.025+00	2026-07-25 07:45:39.025+00
\.


--
-- Data for Name: secrets_provider_connection; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."secrets_provider_connection" ("id", "providerKey", "type", "encryptedSettings", "isEnabled", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: project_secrets_provider_access; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."project_secrets_provider_access" ("secretsProviderConnectionId", "projectId", "createdAt", "updatedAt", "role") FROM stdin;
\.


--
-- Data for Name: role_mapping_rule; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."role_mapping_rule" ("id", "expression", "role", "type", "order", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: role_mapping_rule_project; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."role_mapping_rule_project" ("roleMappingRuleId", "projectId") FROM stdin;
\.


--
-- Data for Name: scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."scope" ("slug", "displayName", "description") FROM stdin;
workflow:unpublish	Unpublish Workflow	Allows unpublishing workflows.
workflow:unshare	Unshare Workflow	Allows removing workflow shares.
credential:unshare	Unshare Credential	Allows removing credential shares.
agent:create	Create Agent	Allows creating new agents in a project.
agent:read	Read Agent	Allows reading agent configuration and history.
agent:update	Update Agent	Allows updating, building, publishing, and managing integrations of agents.
agent:delete	Delete Agent	Allows deleting agents.
agent:list	List Agents	Allows listing agents in a project.
agent:execute	Execute Agent	Allows running agents in chat.
agent:publish	Publish Agent	Allows publishing agents.
agent:unpublish	Unpublish Agent	Allows unpublishing agents.
agent:manage	agent:manage	\N
aiAssistant:manage	Manage AI Usage	Allows managing AI Usage settings.
annotationTag:create	Create Annotation Tag	Allows creating new annotation tags.
annotationTag:read	annotationTag:read	\N
annotationTag:update	annotationTag:update	\N
annotationTag:delete	annotationTag:delete	\N
annotationTag:list	annotationTag:list	\N
auditLogs:manage	auditLogs:manage	\N
banner:dismiss	banner:dismiss	\N
community:register	community:register	\N
communityPackage:install	communityPackage:install	\N
communityPackage:uninstall	communityPackage:uninstall	\N
communityPackage:update	communityPackage:update	\N
communityPackage:list	communityPackage:list	\N
communityPackage:manage	communityPackage:manage	\N
credential:share	credential:share	\N
credential:shareGlobally	credential:shareGlobally	\N
credential:move	credential:move	\N
credential:connect	Connect End-User Credential	Allows connecting an own account to an end-user credential.
credential:createEndUser	Manage End-User Credential	Allows creating, deleting, and changing the type of end-user credentials, which resolve to each user's own connection.
credential:create	credential:create	\N
credential:read	credential:read	\N
credential:update	credential:update	\N
credential:delete	credential:delete	\N
credential:list	credential:list	\N
externalSecretsProvider:sync	externalSecretsProvider:sync	\N
externalSecretsProvider:create	externalSecretsProvider:create	\N
externalSecretsProvider:read	externalSecretsProvider:read	\N
externalSecretsProvider:update	externalSecretsProvider:update	\N
externalSecretsProvider:delete	externalSecretsProvider:delete	\N
externalSecretsProvider:list	externalSecretsProvider:list	\N
externalSecret:list	externalSecret:list	\N
eventBusDestination:test	eventBusDestination:test	\N
eventBusDestination:create	eventBusDestination:create	\N
eventBusDestination:read	eventBusDestination:read	\N
eventBusDestination:update	eventBusDestination:update	\N
eventBusDestination:delete	eventBusDestination:delete	\N
eventBusDestination:list	eventBusDestination:list	\N
ldap:sync	ldap:sync	\N
ldap:manage	ldap:manage	\N
license:manage	license:manage	\N
logStreaming:manage	logStreaming:manage	\N
orchestration:read	orchestration:read	\N
orchestration:list	orchestration:list	\N
project:create	project:create	\N
project:read	project:read	\N
project:update	project:update	\N
project:delete	project:delete	\N
project:list	project:list	\N
project:export	Export Project	Allows including projects in a portable package export.
saml:manage	saml:manage	\N
securityAudit:generate	securityAudit:generate	\N
securitySettings:manage	securitySettings:manage	\N
sourceControl:pull	sourceControl:pull	\N
sourceControl:push	sourceControl:push	\N
sourceControl:manage	sourceControl:manage	\N
tag:create	tag:create	\N
tag:read	tag:read	\N
tag:update	tag:update	\N
tag:delete	tag:delete	\N
tag:list	tag:list	\N
user:resetPassword	user:resetPassword	\N
user:changeRole	user:changeRole	\N
user:enforceMfa	user:enforceMfa	\N
user:generateInviteLink	user:generateInviteLink	\N
user:create	user:create	\N
user:read	user:read	\N
user:update	user:update	\N
user:delete	user:delete	\N
user:list	user:list	\N
variable:create	variable:create	\N
variable:read	variable:read	\N
variable:update	variable:update	\N
variable:delete	variable:delete	\N
variable:list	variable:list	\N
projectVariable:create	projectVariable:create	\N
projectVariable:read	projectVariable:read	\N
projectVariable:update	projectVariable:update	\N
projectVariable:delete	projectVariable:delete	\N
projectVariable:list	projectVariable:list	\N
workersView:manage	workersView:manage	\N
workflow:share	workflow:share	\N
workflow:execute	workflow:execute	\N
workflow:execute-chat	Execute Workflow in Chat	Allows executing workflows in chat.
workflow:export	Export Workflow	Allows including workflows in a portable package export.
workflow:import	Import Workflow	Allows importing workflows from a portable package into the project.
workflow:move	workflow:move	\N
workflow:activate	workflow:activate	\N
workflow:deactivate	workflow:deactivate	\N
workflow:create	workflow:create	\N
workflow:read	workflow:read	\N
workflow:update	workflow:update	\N
workflow:delete	workflow:delete	\N
workflow:list	workflow:list	\N
folder:create	folder:create	\N
folder:read	folder:read	\N
folder:update	folder:update	\N
folder:delete	folder:delete	\N
folder:list	folder:list	\N
folder:move	folder:move	\N
insights:list	insights:list	\N
insights:read	Read Insights	Allows reading insights data.
oidc:manage	oidc:manage	\N
provisioning:manage	provisioning:manage	\N
dataTable:create	dataTable:create	\N
dataTable:read	dataTable:read	\N
dataTable:update	dataTable:update	\N
dataTable:delete	dataTable:delete	\N
dataTable:list	dataTable:list	\N
dataTable:readRow	dataTable:readRow	\N
dataTable:writeRow	dataTable:writeRow	\N
dataTable:readColumn	dataTable:readColumn	\N
dataTable:writeColumn	dataTable:writeColumn	\N
dataTable:listProject	dataTable:listProject	\N
execution:delete	execution:delete	\N
execution:read	execution:read	\N
execution:retry	execution:retry	\N
execution:list	execution:list	\N
execution:get	execution:get	\N
execution:reveal	execution:reveal	\N
testRun:read	Read Test Run	Allows reading evaluation test runs and their per-case results.
testRun:list	List Test Runs	Allows listing evaluation test runs for a workflow.
workflowTags:update	workflowTags:update	\N
workflowTags:list	workflowTags:list	\N
role:manage	role:manage	\N
role:read	role:read	\N
role:manageProject	Manage project roles	Allows creating, editing, and deleting project role definitions.
mcp:manage	mcp:manage	\N
mcp:oauth	mcp:oauth	\N
mcpApiKey:create	mcpApiKey:create	\N
mcpApiKey:rotate	mcpApiKey:rotate	\N
chatHub:manage	chatHub:manage	\N
chatHub:message	chatHub:message	\N
chatHubAgent:create	chatHubAgent:create	\N
chatHubAgent:read	chatHubAgent:read	\N
chatHubAgent:update	chatHubAgent:update	\N
chatHubAgent:delete	chatHubAgent:delete	\N
chatHubAgent:list	chatHubAgent:list	\N
breakingChanges:list	breakingChanges:list	\N
apiKey:manage	apiKey:manage	\N
apiKey:list	apiKey:list	\N
apiKey:create	apiKey:create	\N
apiKey:delete	apiKey:delete	\N
apiKey:update	apiKey:update	\N
encryptionKey:manage	Manage Encryption Keys	Allows listing and rotating instance encryption keys.
credentialResolver:create	credentialResolver:create	\N
credentialResolver:read	credentialResolver:read	\N
credentialResolver:update	credentialResolver:update	\N
credentialResolver:delete	credentialResolver:delete	\N
credentialResolver:list	credentialResolver:list	\N
instanceAi:message	instanceAi:message	\N
instanceAi:manage	instanceAi:manage	\N
instanceAi:gateway	instanceAi:gateway	\N
instanceAi:eval	instanceAi:eval	\N
roleMappingRule:create	roleMappingRule:create	\N
roleMappingRule:read	roleMappingRule:read	\N
roleMappingRule:update	roleMappingRule:update	\N
roleMappingRule:delete	roleMappingRule:delete	\N
roleMappingRule:list	roleMappingRule:list	\N
otel:manage	otel:manage	\N
workflow:publish	Publish Workflow	Allows publishing workflows.
workflow:enableRedaction	workflow:enableRedaction	\N
workflow:disableRedaction	workflow:disableRedaction	\N
\.


--
-- Data for Name: role_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."role_scope" ("roleSlug", "scopeSlug") FROM stdin;
global:owner	workflow:unpublish
global:owner	workflow:unshare
global:owner	credential:unshare
global:owner	agent:create
global:owner	agent:read
global:owner	agent:update
global:owner	agent:delete
global:owner	agent:list
global:owner	agent:execute
global:owner	agent:publish
global:owner	agent:unpublish
global:owner	agent:manage
global:owner	aiAssistant:manage
global:owner	annotationTag:create
global:owner	annotationTag:read
global:owner	annotationTag:update
global:owner	annotationTag:delete
global:owner	annotationTag:list
global:owner	auditLogs:manage
global:owner	banner:dismiss
global:owner	community:register
global:owner	communityPackage:install
global:owner	communityPackage:uninstall
global:owner	communityPackage:update
global:owner	communityPackage:list
global:owner	credential:share
global:owner	credential:shareGlobally
global:owner	credential:move
global:owner	credential:connect
global:owner	credential:createEndUser
global:owner	credential:create
global:owner	credential:read
global:owner	credential:update
global:owner	credential:delete
global:owner	credential:list
global:owner	externalSecretsProvider:sync
global:owner	externalSecretsProvider:create
global:owner	externalSecretsProvider:read
global:owner	externalSecretsProvider:update
global:owner	externalSecretsProvider:delete
global:owner	externalSecretsProvider:list
global:owner	externalSecret:list
global:owner	eventBusDestination:test
global:owner	eventBusDestination:create
global:owner	eventBusDestination:read
global:owner	eventBusDestination:update
global:owner	eventBusDestination:delete
global:owner	eventBusDestination:list
global:owner	ldap:sync
global:owner	ldap:manage
global:owner	license:manage
global:owner	logStreaming:manage
global:owner	orchestration:read
global:owner	project:create
global:owner	project:read
global:owner	project:update
global:owner	project:delete
global:owner	project:list
global:owner	project:export
global:owner	saml:manage
global:owner	securityAudit:generate
global:owner	securitySettings:manage
global:owner	sourceControl:pull
global:owner	sourceControl:push
global:owner	sourceControl:manage
global:owner	tag:create
global:owner	tag:read
global:owner	tag:update
global:owner	tag:delete
global:owner	tag:list
global:owner	user:resetPassword
global:owner	user:changeRole
global:owner	user:enforceMfa
global:owner	user:generateInviteLink
global:owner	user:create
global:owner	user:read
global:owner	user:update
global:owner	user:delete
global:owner	user:list
global:owner	variable:create
global:owner	variable:read
global:owner	variable:update
global:owner	variable:delete
global:owner	variable:list
global:owner	projectVariable:create
global:owner	projectVariable:read
global:owner	projectVariable:update
global:owner	projectVariable:delete
global:owner	projectVariable:list
global:owner	workersView:manage
global:owner	workflow:share
global:owner	workflow:execute
global:owner	workflow:execute-chat
global:owner	workflow:export
global:owner	workflow:import
global:owner	workflow:move
global:owner	workflow:create
global:owner	workflow:read
global:owner	workflow:update
global:owner	workflow:delete
global:owner	workflow:list
global:owner	folder:create
global:owner	folder:read
global:owner	folder:update
global:owner	folder:delete
global:owner	folder:list
global:owner	folder:move
global:owner	insights:list
global:owner	insights:read
global:owner	oidc:manage
global:owner	provisioning:manage
global:owner	dataTable:create
global:owner	dataTable:read
global:owner	dataTable:update
global:owner	dataTable:delete
global:owner	dataTable:list
global:owner	dataTable:readRow
global:owner	dataTable:writeRow
global:owner	dataTable:readColumn
global:owner	dataTable:writeColumn
global:owner	dataTable:listProject
global:owner	execution:reveal
global:owner	role:manage
global:owner	role:read
global:owner	mcp:manage
global:owner	mcp:oauth
global:owner	mcpApiKey:create
global:owner	mcpApiKey:rotate
global:owner	chatHub:manage
global:owner	chatHub:message
global:owner	chatHubAgent:create
global:owner	chatHubAgent:read
global:owner	chatHubAgent:update
global:owner	chatHubAgent:delete
global:owner	chatHubAgent:list
global:owner	breakingChanges:list
global:owner	apiKey:manage
global:owner	apiKey:list
global:owner	apiKey:create
global:owner	apiKey:delete
global:owner	apiKey:update
global:owner	encryptionKey:manage
global:owner	credentialResolver:create
global:owner	credentialResolver:read
global:owner	credentialResolver:update
global:owner	credentialResolver:delete
global:owner	credentialResolver:list
global:owner	instanceAi:message
global:owner	instanceAi:manage
global:owner	instanceAi:gateway
global:owner	instanceAi:eval
global:owner	roleMappingRule:create
global:owner	roleMappingRule:read
global:owner	roleMappingRule:update
global:owner	roleMappingRule:delete
global:owner	roleMappingRule:list
global:owner	otel:manage
global:owner	workflow:publish
global:owner	workflow:enableRedaction
global:owner	workflow:disableRedaction
global:admin	workflow:unpublish
global:admin	workflow:unshare
global:admin	credential:unshare
global:admin	agent:create
global:admin	agent:read
global:admin	agent:update
global:admin	agent:delete
global:admin	agent:list
global:admin	agent:execute
global:admin	agent:publish
global:admin	agent:unpublish
global:admin	agent:manage
global:admin	aiAssistant:manage
global:admin	annotationTag:create
global:admin	annotationTag:read
global:admin	annotationTag:update
global:admin	annotationTag:delete
global:admin	annotationTag:list
global:admin	auditLogs:manage
global:admin	banner:dismiss
global:admin	community:register
global:admin	communityPackage:install
global:admin	communityPackage:uninstall
global:admin	communityPackage:update
global:admin	communityPackage:list
global:admin	credential:share
global:admin	credential:shareGlobally
global:admin	credential:move
global:admin	credential:connect
global:admin	credential:createEndUser
global:admin	credential:create
global:admin	credential:read
global:admin	credential:update
global:admin	credential:delete
global:admin	credential:list
global:admin	externalSecretsProvider:sync
global:admin	externalSecretsProvider:create
global:admin	externalSecretsProvider:read
global:admin	externalSecretsProvider:update
global:admin	externalSecretsProvider:delete
global:admin	externalSecretsProvider:list
global:admin	externalSecret:list
global:admin	eventBusDestination:test
global:admin	eventBusDestination:create
global:admin	eventBusDestination:read
global:admin	eventBusDestination:update
global:admin	eventBusDestination:delete
global:admin	eventBusDestination:list
global:admin	ldap:sync
global:admin	ldap:manage
global:admin	license:manage
global:admin	logStreaming:manage
global:admin	orchestration:read
global:admin	project:create
global:admin	project:read
global:admin	project:update
global:admin	project:delete
global:admin	project:list
global:admin	project:export
global:admin	saml:manage
global:admin	securityAudit:generate
global:admin	securitySettings:manage
global:admin	sourceControl:pull
global:admin	sourceControl:push
global:admin	sourceControl:manage
global:admin	tag:create
global:admin	tag:read
global:admin	tag:update
global:admin	tag:delete
global:admin	tag:list
global:admin	user:resetPassword
global:admin	user:changeRole
global:admin	user:enforceMfa
global:admin	user:generateInviteLink
global:admin	user:create
global:admin	user:read
global:admin	user:update
global:admin	user:delete
global:admin	user:list
global:admin	variable:create
global:admin	variable:read
global:admin	variable:update
global:admin	variable:delete
global:admin	variable:list
global:admin	projectVariable:create
global:admin	projectVariable:read
global:admin	projectVariable:update
global:admin	projectVariable:delete
global:admin	projectVariable:list
global:admin	workersView:manage
global:admin	workflow:share
global:admin	workflow:execute
global:admin	workflow:execute-chat
global:admin	workflow:export
global:admin	workflow:import
global:admin	workflow:move
global:admin	workflow:create
global:admin	workflow:read
global:admin	workflow:update
global:admin	workflow:delete
global:admin	workflow:list
global:admin	folder:create
global:admin	folder:read
global:admin	folder:update
global:admin	folder:delete
global:admin	folder:list
global:admin	folder:move
global:admin	insights:list
global:admin	insights:read
global:admin	oidc:manage
global:admin	provisioning:manage
global:admin	dataTable:create
global:admin	dataTable:read
global:admin	dataTable:update
global:admin	dataTable:delete
global:admin	dataTable:list
global:admin	dataTable:readRow
global:admin	dataTable:writeRow
global:admin	dataTable:readColumn
global:admin	dataTable:writeColumn
global:admin	dataTable:listProject
global:admin	execution:reveal
global:admin	role:manage
global:admin	role:read
global:admin	mcp:manage
global:admin	mcp:oauth
global:admin	mcpApiKey:create
global:admin	mcpApiKey:rotate
global:admin	chatHub:manage
global:admin	chatHub:message
global:admin	chatHubAgent:create
global:admin	chatHubAgent:read
global:admin	chatHubAgent:update
global:admin	chatHubAgent:delete
global:admin	chatHubAgent:list
global:admin	breakingChanges:list
global:admin	apiKey:manage
global:admin	apiKey:list
global:admin	apiKey:create
global:admin	apiKey:delete
global:admin	apiKey:update
global:admin	encryptionKey:manage
global:admin	credentialResolver:create
global:admin	credentialResolver:read
global:admin	credentialResolver:update
global:admin	credentialResolver:delete
global:admin	credentialResolver:list
global:admin	instanceAi:message
global:admin	instanceAi:manage
global:admin	instanceAi:gateway
global:admin	instanceAi:eval
global:admin	roleMappingRule:create
global:admin	roleMappingRule:read
global:admin	roleMappingRule:update
global:admin	roleMappingRule:delete
global:admin	roleMappingRule:list
global:admin	otel:manage
global:admin	workflow:publish
global:admin	workflow:enableRedaction
global:admin	workflow:disableRedaction
global:member	annotationTag:create
global:member	annotationTag:read
global:member	annotationTag:update
global:member	annotationTag:delete
global:member	annotationTag:list
global:member	eventBusDestination:test
global:member	eventBusDestination:list
global:member	tag:create
global:member	tag:read
global:member	tag:update
global:member	tag:list
global:member	user:list
global:member	variable:read
global:member	variable:list
global:member	dataTable:list
global:member	mcp:oauth
global:member	mcpApiKey:create
global:member	mcpApiKey:rotate
global:member	chatHub:message
global:member	chatHubAgent:create
global:member	chatHubAgent:read
global:member	chatHubAgent:update
global:member	chatHubAgent:delete
global:member	chatHubAgent:list
global:member	apiKey:list
global:member	apiKey:create
global:member	apiKey:delete
global:member	apiKey:update
global:member	credentialResolver:list
global:member	instanceAi:message
global:member	instanceAi:gateway
global:chatUser	chatHub:message
global:chatUser	chatHubAgent:create
global:chatUser	chatHubAgent:read
global:chatUser	chatHubAgent:update
global:chatUser	chatHubAgent:delete
global:chatUser	chatHubAgent:list
project:admin	workflow:unpublish
project:admin	credential:unshare
project:admin	agent:create
project:admin	agent:read
project:admin	agent:update
project:admin	agent:delete
project:admin	agent:list
project:admin	agent:execute
project:admin	agent:publish
project:admin	agent:unpublish
project:admin	credential:share
project:admin	credential:move
project:admin	credential:connect
project:admin	credential:createEndUser
project:admin	credential:create
project:admin	credential:read
project:admin	credential:update
project:admin	credential:delete
project:admin	credential:list
project:admin	project:read
project:admin	project:update
project:admin	project:delete
project:admin	project:list
project:admin	project:export
project:admin	sourceControl:push
project:admin	projectVariable:create
project:admin	projectVariable:read
project:admin	projectVariable:update
project:admin	projectVariable:delete
project:admin	projectVariable:list
project:admin	workflow:execute
project:admin	workflow:execute-chat
project:admin	workflow:export
project:admin	workflow:import
project:admin	workflow:move
project:admin	workflow:create
project:admin	workflow:read
project:admin	workflow:update
project:admin	workflow:delete
project:admin	workflow:list
project:admin	folder:create
project:admin	folder:read
project:admin	folder:update
project:admin	folder:delete
project:admin	folder:list
project:admin	folder:move
project:admin	dataTable:create
project:admin	dataTable:read
project:admin	dataTable:update
project:admin	dataTable:delete
project:admin	dataTable:readRow
project:admin	dataTable:writeRow
project:admin	dataTable:readColumn
project:admin	dataTable:writeColumn
project:admin	dataTable:listProject
project:admin	execution:reveal
project:admin	workflow:publish
project:admin	workflow:enableRedaction
project:admin	workflow:disableRedaction
project:personalOwner	workflow:unpublish
project:personalOwner	workflow:unshare
project:personalOwner	credential:unshare
project:personalOwner	agent:create
project:personalOwner	agent:read
project:personalOwner	agent:update
project:personalOwner	agent:delete
project:personalOwner	agent:list
project:personalOwner	agent:execute
project:personalOwner	agent:publish
project:personalOwner	agent:unpublish
project:personalOwner	credential:share
project:personalOwner	credential:move
project:personalOwner	credential:connect
project:personalOwner	credential:createEndUser
project:personalOwner	credential:create
project:personalOwner	credential:read
project:personalOwner	credential:update
project:personalOwner	credential:delete
project:personalOwner	credential:list
project:personalOwner	project:read
project:personalOwner	project:list
project:personalOwner	project:export
project:personalOwner	workflow:share
project:personalOwner	workflow:execute
project:personalOwner	workflow:execute-chat
project:personalOwner	workflow:export
project:personalOwner	workflow:import
project:personalOwner	workflow:move
project:personalOwner	workflow:create
project:personalOwner	workflow:read
project:personalOwner	workflow:update
project:personalOwner	workflow:delete
project:personalOwner	workflow:list
project:personalOwner	folder:create
project:personalOwner	folder:read
project:personalOwner	folder:update
project:personalOwner	folder:delete
project:personalOwner	folder:list
project:personalOwner	folder:move
project:personalOwner	dataTable:create
project:personalOwner	dataTable:read
project:personalOwner	dataTable:update
project:personalOwner	dataTable:delete
project:personalOwner	dataTable:readRow
project:personalOwner	dataTable:writeRow
project:personalOwner	dataTable:readColumn
project:personalOwner	dataTable:writeColumn
project:personalOwner	dataTable:listProject
project:personalOwner	execution:reveal
project:personalOwner	workflow:publish
project:personalOwner	workflow:enableRedaction
project:personalOwner	workflow:disableRedaction
project:editor	workflow:unpublish
project:editor	agent:create
project:editor	agent:read
project:editor	agent:update
project:editor	agent:delete
project:editor	agent:list
project:editor	agent:execute
project:editor	agent:publish
project:editor	agent:unpublish
project:editor	credential:connect
project:editor	credential:create
project:editor	credential:read
project:editor	credential:update
project:editor	credential:delete
project:editor	credential:list
project:editor	project:read
project:editor	project:list
project:editor	project:export
project:editor	projectVariable:create
project:editor	projectVariable:read
project:editor	projectVariable:update
project:editor	projectVariable:delete
project:editor	projectVariable:list
project:editor	workflow:execute
project:editor	workflow:execute-chat
project:editor	workflow:export
project:editor	workflow:import
project:editor	workflow:create
project:editor	workflow:read
project:editor	workflow:update
project:editor	workflow:delete
project:editor	workflow:list
project:editor	folder:create
project:editor	folder:read
project:editor	folder:update
project:editor	folder:delete
project:editor	folder:list
project:editor	dataTable:create
project:editor	dataTable:read
project:editor	dataTable:update
project:editor	dataTable:delete
project:editor	dataTable:readRow
project:editor	dataTable:writeRow
project:editor	dataTable:readColumn
project:editor	dataTable:writeColumn
project:editor	dataTable:listProject
project:editor	workflow:publish
project:viewer	agent:read
project:viewer	agent:list
project:viewer	agent:execute
project:viewer	credential:read
project:viewer	credential:list
project:viewer	project:read
project:viewer	project:list
project:viewer	project:export
project:viewer	projectVariable:read
project:viewer	projectVariable:list
project:viewer	workflow:execute-chat
project:viewer	workflow:export
project:viewer	workflow:read
project:viewer	workflow:list
project:viewer	folder:read
project:viewer	folder:list
project:viewer	dataTable:read
project:viewer	dataTable:readRow
project:viewer	dataTable:readColumn
project:viewer	dataTable:listProject
project:chatUser	agent:execute
project:chatUser	workflow:execute-chat
credential:owner	credential:unshare
credential:owner	credential:share
credential:owner	credential:move
credential:owner	credential:connect
credential:owner	credential:read
credential:owner	credential:update
credential:owner	credential:delete
credential:user	credential:connect
credential:user	credential:read
workflow:owner	workflow:unpublish
workflow:owner	workflow:unshare
workflow:owner	workflow:share
workflow:owner	workflow:execute
workflow:owner	workflow:execute-chat
workflow:owner	workflow:export
workflow:owner	workflow:move
workflow:owner	workflow:read
workflow:owner	workflow:update
workflow:owner	workflow:delete
workflow:owner	execution:reveal
workflow:owner	workflow:publish
workflow:owner	workflow:enableRedaction
workflow:owner	workflow:disableRedaction
workflow:editor	workflow:unpublish
workflow:editor	workflow:execute
workflow:editor	workflow:execute-chat
workflow:editor	workflow:export
workflow:editor	workflow:read
workflow:editor	workflow:update
workflow:editor	workflow:publish
secretsProviderConnection:owner	externalSecretsProvider:sync
secretsProviderConnection:owner	externalSecretsProvider:read
secretsProviderConnection:owner	externalSecretsProvider:update
secretsProviderConnection:owner	externalSecretsProvider:delete
secretsProviderConnection:owner	externalSecretsProvider:list
secretsProviderConnection:owner	externalSecret:list
secretsProviderConnection:user	externalSecretsProvider:read
secretsProviderConnection:user	externalSecretsProvider:list
secretsProviderConnection:user	externalSecret:list
\.


--
-- Data for Name: workflow_history; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."workflow_history" ("versionId", "workflowId", "authors", "createdAt", "updatedAt", "nodes", "connections", "name", "autosaved", "description", "nodeGroups") FROM stdin;
02a02cd5-1e42-4fd5-a557-9deda19f620d	1AzpEC2wr7qj2qDP	Nadz Gundaya	2026-07-25 09:37:41.749+00	2026-07-25 09:57:06.575+00	[{"parameters":{"rule":{"interval":[{"field":"minutes","minutesInterval":30}]}},"type":"n8n-nodes-base.scheduleTrigger","typeVersion":1.3,"position":[-256,-64],"id":"ac15a515-fabd-429a-985d-4a06ebf49f3c","name":"Schedule Trigger"},{"parameters":{"sendTo":"lilininilikeu@gmail.com","subject":"You're getting this email because you're gay.","message":"it worked! NYAHAHAHAHHAHAHA","options":{"senderName":"Alex Cutie"}},"type":"n8n-nodes-base.gmail","typeVersion":2.2,"position":[-48,-64],"id":"7b97a9b6-e37b-4bd2-a6bb-295648d5fd2b","name":"Send a message","webhookId":"ae9af7fc-93b2-4500-9302-a5df83ef5ac2","alwaysOutputData":false,"retryOnFail":false,"notesInFlow":false,"credentials":{"gmailOAuth2":{"id":"m1wdLMxqifebWQO5","name":"Gmail account"}}}]	{"Schedule Trigger":{"main":[[{"node":"Send a message","type":"main","index":0}]]}}	Gmail Auto Send	t		[]
\.


--
-- Data for Name: workflow_published_version; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."workflow_published_version" ("workflowId", "publishedVersionId", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: scheduled_job; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."scheduled_job" ("id", "name", "workflowId", "nodeId", "taskType", "payload", "kind", "cronExpression", "timezone", "intervalSeconds", "fireAt", "enabled", "nextRunAt", "lastFiredAt", "maxAttempts", "createdAt", "updatedAt", "recurrenceUnit", "recurrenceSize") FROM stdin;
\.


--
-- Data for Name: scheduled_task; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."scheduled_task" ("id", "jobId", "taskType", "payload", "scheduledFor", "runAt", "status", "attempts", "maxAttempts", "claimedBy", "leaseExpiresAt", "leaseEpoch", "startedAt", "finishedAt", "errorMessage", "createdAt") FROM stdin;
\.


--
-- Data for Name: settings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."settings" ("key", "value", "loadOnStartup") FROM stdin;
ui.banners.dismissed	["V1"]	t
features.ldap	{"loginEnabled":false,"loginLabel":"","connectionUrl":"","allowUnauthorizedCerts":false,"connectionSecurity":"none","connectionPort":389,"baseDn":"","bindingAdminDn":"","bindingAdminPassword":"","firstNameAttribute":"","lastNameAttribute":"","emailAttribute":"","loginIdAttribute":"","ldapIdAttribute":"","userFilter":"","synchronizationEnabled":false,"synchronizationInterval":60,"searchPageSize":0,"searchTimeout":60,"enforceEmailUniqueness":true}	t
chat.access.enabled	false	t
userManagement.isInstanceOwnerSetUp	true	t
license.cert	eyJsaWNlbnNlS2V5IjoiLS0tLS1CRUdJTiBMSUNFTlNFIEtFWS0tLS0tXG5wckp5dDdNTE9ERlQya01oT2RZd1dCejJhNGdPVW9iK0wvc2pGV3ltR25RNTRjWXpzb3pRa25PY2QzaVRIU1YvXG5LQllwd2tnbTI3bGRkd0sxa3BOZ0l5YW1pVVNzTXRLVFl6dDR6N0Y4eWI5SU1JQWgvSFZrWmhENFFBdWRpeUpTXG5DUDhoMUdqMEc3RXJWcjhJWjBzQllzYlliR05HbUNyTzIrNUFwa2hQckJieWttdjNLMjRRWlF2d2NQampKb3IrXG5YWTdrR0x0bkxDeS9RenA5MThnTU5iZXRiNE9GQ2JQWmRQTnA5VnBpYkpTVGM4VUxZNXRybGxUL0ZFSTFtOVA5XG5VWVZvYjZsMkNEZFNKcVRrc3F5d1JPOWtzNHRycmR0aVRCN0djZUFTeE8zNXNGSjZhVjdEOGxMeHR4dVdtWmMrXG5MaWZNNEJFQloyei9ZME5aMEUwSEtnPT18fFUyRnNkR1ZrWDE5bVN6a3JBWmdybjhSOENnb3hWZ3BOenZFNnI1XG5ZM255U0lBQkVxSVFacXA3T1dTYXlRTjd0VTlXajlGQWlnMllEd2Z6c1F4NjkxZEE1TEdoWTV2cG53RGhSU1RGXG5PV3pHZkpGOWh5d0FDQ2hWNWdFdGxENXhkbU01bDcyYVMrdDN4MUxlNzIzZVNPNndaUUdSOGY3Vkp1YUc2cFRiXG5WTFFEaEZ2RmRDTEVXTmd6NmhncHV2cEE5MndHb3NKdUM0WDFiemxKV0R5dHVhK2lqanVKbk1kSTJYd2FsUGxMXG41MUVSVDFycDArNDhqZVplRm14TXN1OWxrZHU1Q0c5OThneSs0RWRzajRLQ2N4Q2ozek8vbGhmaWlhYTFxN0FnXG52Z0EybXR6Zkw0ZDJlYjJxbVlNN3dvZ05DYlhieVVGMDhlamI3L3E2end5YUlVSitJbjdBeUlCYVBnb3RRSmJFXG5tOGtqTlVqTmFkK3ROWGJiK2IvSHBSYjRlbU5EV0NwdlZwUktrNGNqWDhVNzVkQ1J3QUNpa2tDQjZFYVZ5MGgvXG51R0NKYi9nSWt0ald6RDVxN010T05QcE1yNVJITWxtUnZSSkpjUVRCamUwbndvc3liNDZ0LzFUa1pTWDFLOUVNXG5keGVHM0h5V0VNRzB5WFVQeHlRM25VSW9Zd0tPV0s2Sk9nTTduVTl0RzNlTUtqM2tMRHRJbjdtbEhpOGh1WGZ2XG5yUG5Oc3VwR0JxSjFhUE5jS24zVkRQR0lQakZZVGlIanRoSlUycnlvczRURUE1MnBreWh0ZmhMU3dQbXFXYmpjXG5tbzNwaW9PTWR0SUM2d0U3cEU1ZEFUdmJnbSs5aFFNdmMxM25ObWRlcG1EcW90QkRWN1JSWkxWQlg5cERTZGdpXG5laEFWUG91RDVBckR3eTZnMnhVZWgzdVdNRzdtVTlUbkI1TmhrUTdtM2xxTERUWXJYNVdtejZRbkFSWnZ3RkFMXG4yQmM2TGhML2FRaGJuQXlUazM1ai9RcFRERWpoYnhXd1V1T2ZnNFBKNFJIRTNEc2lza0pPZzFsQXFRRWJ2aWozXG5CcWhzTW0wZlJrMlZmOW1hbVZrdlF2UXpXeWZPN3puN21PaDNpOHNuY0NFYzVVUFVGbXdJOGFvMG9CQzdQYmhHXG50RUt1VTJsMjRDWENlT0Uxd0tYc2pXV2pRUlhFSlVuaWlCWncwc2dDc2lkME9NTGNvUVdXUEFzTjFvWU9RRWVNXG42cFhBZnRKNXlaNnN5WkV5OGVrRG1MakpoVmZQTkdMcjlGVjBaN3FyRzV2NFRIamtnSTlGeGlwM09oMzRkTmlxXG5GMnFoZG0rR1Fnekt4UUExcjNlcUhqajVqWEpaaXU2NW92ak5HOUd4VUZpQWdJVi92WlRhRy9KOTR0SHVuZ0syXG5sMzRhYlJVTmt4am9zSTEzdjIzOXR6T3ZkcFhBcEVqVkFrU0txTm5ySVNGaVl6TGVnTGFOVnhxaVpWMWdvdlhOXG5SRDZIS0ZBbURBakZlUnlCS2dKV1BCdEFQTlRWbE1QZjBaLzZpeFl3a0hWNUdTa29FMU1icE9KcXN5NXR0ZjlsXG5pYURhWllheE5sNWRWZ2tnbFprV1dxTHFOUG9vKzRLZHdFaURWejg0SGtyOHFyUVZXT25GVTNidkI4aXJWUDlQXG4wdWc4MEF5aHZmRERLbjFXTlRwaWk0Zlk4S1NjckxIQWhONy9BOEs2UmJNL1kxVVhyZ0N3WGJjZHFtNkEzQ3loXG5hcUNyNk95OVVaQitsaHZVbmhRZUVrTnMyOVd2WHdiL1BudmZ6UEpmb2FLS3ZQQktFS1QvWXhMVFNCVno5N2xEXG5nSWZzVGRGMC9vRjFzTklnSGFEUXpXZ2hxTFVVM2NuY2FWTDBrcWFlSElNdWNmaW5FZXFiemZMYnRMRndkSTAwXG50U0ZRUXh2Y0l1Z2E1K0FvZ2laVGFXWjF4Rm8xTUZld000WHlhM3ZJemFqOFlmWG5aRThaRGtuYk9GTzdtN0xEXG5oN3FHNU9tY2pYRnhhaHhNTnIrSW85UlRKN2NxWUZ5akplSEJ5aWtpTHhrckNBdm5qdGtSaHFqQkhkNDNacVNJXG4rNnZBcFFISDM2M0pOVUZyb05mVGxPQ21IZW90ZnRLdk5BNTA0ckp3Mjk3NXlLMEczcnJiK2kySE5YN0Y5U0MyXG5ZUFdXd3dxSjA5Vm1vRTBoNEVONWhvUHl5bW83aTdXNHFTUVhyUjJpZm1Dd1ZvZytqeEw4cGMybEd4RWk1bVRqXG5neFRqSWJsamNHeURIdnN0TDZ3QkhlQ2VpY0wyNVp4TTVVMVltNGRjb1JvWExlQVh5QnFXbndOS2R5T1ZzK29aXG5OTDRNcnJYWmh3ejRVdzlkSjY3RElDMUNJWEs5QURDRDY0TC9SZi8zVGlqVGhMQitUSUYvSkh2V2VzeXZybXpNXG54YVdGZjY3VGMwYytaNEp0TFZuLy8vRUFXOEJwcWFkRkdmdllxVXBNTERER2duWk9NQkJ3bWZqSjd2eXF4WHgxXG5wU1h0TERwSStsQ2FmVWlNTkd5djVibUZEVmhTaXNLRytrdTdoVksvT1BJVDVuTFpVNEk1Ukx5Q2h2VmNseTF2XG4yZkR3Z1FOY1YzbW54U0t6V040eHdiOWF5RTRJeW9XcHNSRzJKRm4xUVZPWk5KVngyL05rbmVQanhoSjJqdmtlXG44S1E3U3Z4YytqRlpnVXNVMmpPYXQwdndmMnJ4WDlRc0Q2Q2NXYjhPQWhLeVc0QXBISkRqVWtMUnpoNE1waG9JXG5zbmJXS1h0U29EZG41ME9Ld1BSZGJCUGF5Y01RNjRIVWRLcERRdGdMaGFCR01TOVVaV05VWklxV1ltRy9UYituXG4rdlV4MjJzRzhpdWFqTXFDTis2YnJXTVIyMG1KbDZSTjJWdFN1am1nbFM5czBKcnhRWjFvVGpPdGRJNHI4eDVSXG5UY0l0MTNnc3k5TElQSVJSUlg0aE5jUFBWdDBJOU9YaS85U2h3RmJLdlpnTGFWTlVqQ2puMGNLWDFNSmJYdVhjXG42QjQ5SGNDTEJHUE5nVkdJZnVMZ1BBckYvNDhpZ1FMZGtBaGVjMVdjSGxwdUNNOXc9PXx8YUdmV2lPVVBVc2pTXG5FNENwaG5ldytPZXRqdGZ2bHNodlh5OGdFWWZ6RkZXd2VaTVhYQzhlWTlLUEFkTExuT01VTVlZZVNYQmhmSmdYXG5YaENVK2p2NmlQVlR0UFFBTjIyU3JFdlVXR2llMGZSbFRJdXkzS0ZZTng2TzNBL1c5UlZJaU5mallNUlkxVyswXG5vejAwRHloMkpHNndHYkdORlJzaUVLU0FabzF6czFjWHkvdFAyQUlPQ3l1UUxkNzI2VkYyYy9GLzdrYTNDSFZuXG4yTWRuS0J6eURQdDNDZjFLVEw1RjlINXZ4Uk1hQkhzZW1HNDd2Mzh3UHdNVFJjalFoMUU3ZkdmQWM2OVkxK1hnXG5Bdi81VnBOblJpWG5vRS9NN0dVKzYwMTl0VWtuQ1hkYlVrWUZId095RHdOZEhXSWR6dTBpVnpjRlVXVElMZWxrXG5DUFhRaUlucWZnPT1cbi0tLS0tRU5EIExJQ0VOU0UgS0VZLS0tLS0iLCJ4NTA5IjoiLS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tXG5NSUlFRERDQ0FmUUNDUUNxZzJvRFQ4MHh3akFOQmdrcWhraUc5dzBCQVFVRkFEQklNUXN3Q1FZRFZRUUdFd0pFXG5SVEVQTUEwR0ExVUVDQXdHUW1WeWJHbHVNUTh3RFFZRFZRUUhEQVpDWlhKc2FXNHhGekFWQmdOVkJBTU1EbXhwXG5ZMlZ1YzJVdWJqaHVMbWx2TUI0WERUSXlNRFl5TkRBME1UQTBNRm9YRFRJek1EWXlOREEwTVRBME1Gb3dTREVMXG5NQWtHQTFVRUJoTUNSRVV4RHpBTkJnTlZCQWdNQmtKbGNteHBiakVQTUEwR0ExVUVCd3dHUW1WeWJHbHVNUmN3XG5GUVlEVlFRRERBNXNhV05sYm5ObExtNDRiaTVwYnpDQ0FTSXdEUVlKS29aSWh2Y05BUUVCQlFBRGdnRVBBRENDXG5BUW9DZ2dFQkFNQk0wNVhCNDRnNXhmbUNMd2RwVVR3QVQ4K0NCa3lMS0ZzZXprRDVLLzZXaGFYL1hyc2QvUWQwXG4yMEo3d2w1V2RIVTRjVkJtRlJqVndWemtsQ0syeVlKaThtang4c1hzR3E5UTFsYlVlTUtmVjlkc2dmdWhubEFTXG50blFaZ2x1Z09uRjJGZ1JoWGIvakswdHhUb2FvK2JORTZyNGdJRXpwa3RITEJUWXZ2aXVKbXJlZjdXYlBSdDRJXG5uZDlEN2xoeWJlYnloVjdrdXpqUUEvcFBLSFRGczhNVEhaOGhZVXhSeXJwbTMrTVl6UUQrYmpBMlUxRkljdGFVXG53UVhZV2FON3QydVR3Q3Q5ekFLc21ZL1dlT2J2bDNUWk41T05MQXp5V0dDdWxtNWN3S1IzeGJsQlp6WG5CNmdzXG5Pbk4yT0FkU3RjelRWQ3ljbThwY0ZVcnl0S1NLa0dFQ0F3RUFBVEFOQmdrcWhraUc5dzBCQVFVRkFBT0NBZ0VBXG5sSjAxd2NuMXZqWFhDSHVvaTdSMERKMWxseDErZGFmcXlFcVBBMjdKdStMWG1WVkdYUW9yUzFiOHhqVXFVa2NaXG5UQndiV0ZPNXo1ZFptTnZuYnlqYXptKzZvT2cwUE1hWXhoNlRGd3NJMlBPYmM3YkZ2MmVheXdQdC8xQ3BuYzQwXG5xVU1oZnZSeC9HQ1pQQ1d6My8yUlBKV1g5alFEU0hYQ1hxOEJXK0kvM2N1TERaeVkzZkVZQkIwcDNEdlZtYWQ2XG42V0hRYVVyaU4wL0xxeVNPcC9MWmdsbC90MDI5Z1dWdDA1WmliR29LK2NWaFpFY3NMY1VJaHJqMnVGR0ZkM0ltXG5KTGcxSktKN2pLU0JVUU9kSU1EdnNGVUY3WWRNdk11ckNZQTJzT05OOENaK0k1eFFWMUtTOWV2R0hNNWZtd2dTXG5PUEZ2UHp0RENpMC8xdVc5dE9nSHBvcnVvZGFjdCtFWk5rQVRYQ3ZaaXUydy9xdEtSSkY0VTRJVEVtNWFXMGt3XG42enVDOHh5SWt0N3ZoZHM0OFV1UlNHSDlqSnJBZW1sRWl6dEdJTGhHRHF6UUdZYmxoVVFGR01iQmI3amhlTHlDXG5MSjFXT0c2MkYxc3B4Q0tCekVXNXg2cFIxelQxbWhFZ2Q0TWtMYTZ6UFRwYWNyZDk1QWd4YUdLRUxhMVJXU0ZwXG5NdmRoR2s0TnY3aG5iOHIrQnVNUkM2aWVkUE1DelhxL001MGNOOEFnOGJ3K0oxYUZvKzBFSzJoV0phN2tpRStzXG45R3ZGalNkekNGbFVQaEtra1Vaa1NvNWFPdGNRcTdKdTZrV0JoTG9GWUtncHJscDFRVkIwc0daQTZvNkR0cWphXG5HNy9SazZ2YmFZOHdzTllLMnpCWFRUOG5laDVab1JaL1BKTFV0RUV0YzdZPVxuLS0tLS1FTkQgQ0VSVElGSUNBVEUtLS0tLSJ9	f
\.


--
-- Data for Name: shared_credentials; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."shared_credentials" ("credentialsId", "projectId", "role", "createdAt", "updatedAt") FROM stdin;
m1wdLMxqifebWQO5	mZfC7A4PSYI9o6Vm	credential:owner	2026-07-25 09:37:39.825+00	2026-07-25 09:37:39.825+00
\.


--
-- Data for Name: shared_workflow; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."shared_workflow" ("workflowId", "projectId", "role", "createdAt", "updatedAt") FROM stdin;
1AzpEC2wr7qj2qDP	mZfC7A4PSYI9o6Vm	workflow:owner	2026-07-25 09:27:52.17+00	2026-07-25 09:27:52.17+00
\.


--
-- Data for Name: test_run; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."test_run" ("id", "workflowId", "status", "errorCode", "errorDetails", "runAt", "completedAt", "metrics", "createdAt", "updatedAt", "runningInstanceId", "cancelRequested", "workflowVersionId", "evaluationConfigId", "evaluationConfigSnapshot", "collectionId") FROM stdin;
\.


--
-- Data for Name: test_case_execution; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."test_case_execution" ("id", "testRunId", "executionId", "status", "runAt", "completedAt", "errorCode", "errorDetails", "metrics", "createdAt", "updatedAt", "inputs", "outputs", "runIndex") FROM stdin;
\.


--
-- Data for Name: token_exchange_jti; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."token_exchange_jti" ("jti", "expiresAt", "createdAt") FROM stdin;
\.


--
-- Data for Name: trusted_key_source; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."trusted_key_source" ("id", "type", "config", "status", "lastError", "lastRefreshedAt", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: trusted_key; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."trusted_key" ("sourceId", "kid", "data", "createdAt") FROM stdin;
\.


--
-- Data for Name: user_api_keys; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."user_api_keys" ("id", "userId", "label", "apiKey", "createdAt", "updatedAt", "scopes", "audience", "lastUsedAt") FROM stdin;
\.


--
-- Data for Name: user_favorites; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."user_favorites" ("id", "userId", "resourceId", "resourceType") FROM stdin;
\.


--
-- Data for Name: variables; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."variables" ("key", "type", "value", "id", "projectId") FROM stdin;
\.


--
-- Data for Name: webhook_entity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."webhook_entity" ("webhookPath", "method", "node", "webhookId", "pathLength", "workflowId") FROM stdin;
\.


--
-- Data for Name: workflow_builder_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."workflow_builder_session" ("id", "workflowId", "userId", "messages", "previousSummary", "createdAt", "updatedAt", "activeVersionCardId", "resumeAfterRestoreMessageId") FROM stdin;
\.


--
-- Data for Name: workflow_dependency; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."workflow_dependency" ("id", "workflowId", "workflowVersionId", "dependencyType", "dependencyKey", "dependencyInfo", "indexVersionId", "createdAt", "publishedVersionId") FROM stdin;
38	1AzpEC2wr7qj2qDP	23	nodeType	n8n-nodes-base.scheduleTrigger	{"nodeId":"ac15a515-fabd-429a-985d-4a06ebf49f3c","nodeVersion":1.3}	1	2026-07-25 09:37:41.804+00	\N
39	1AzpEC2wr7qj2qDP	23	nodeType	n8n-nodes-base.gmail	{"nodeId":"7b97a9b6-e37b-4bd2-a6bb-295648d5fd2b","nodeVersion":2.2}	1	2026-07-25 09:37:41.804+00	\N
40	1AzpEC2wr7qj2qDP	23	credentialId	m1wdLMxqifebWQO5	{"nodeId":"7b97a9b6-e37b-4bd2-a6bb-295648d5fd2b","nodeVersion":2.2}	1	2026-07-25 09:37:41.804+00	\N
41	1AzpEC2wr7qj2qDP	23	nodeType	n8n-nodes-base.scheduleTrigger	{"nodeId":"ac15a515-fabd-429a-985d-4a06ebf49f3c","nodeVersion":1.3}	1	2026-07-25 09:57:06.575+00	02a02cd5-1e42-4fd5-a557-9deda19f620d
42	1AzpEC2wr7qj2qDP	23	nodeType	n8n-nodes-base.gmail	{"nodeId":"7b97a9b6-e37b-4bd2-a6bb-295648d5fd2b","nodeVersion":2.2}	1	2026-07-25 09:57:06.575+00	02a02cd5-1e42-4fd5-a557-9deda19f620d
43	1AzpEC2wr7qj2qDP	23	credentialId	m1wdLMxqifebWQO5	{"nodeId":"7b97a9b6-e37b-4bd2-a6bb-295648d5fd2b","nodeVersion":2.2}	1	2026-07-25 09:57:06.575+00	02a02cd5-1e42-4fd5-a557-9deda19f620d
\.


--
-- Data for Name: workflow_publication_outbox; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."workflow_publication_outbox" ("id", "workflowId", "publishedVersionId", "status", "errorMessage", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: workflow_publication_trigger_status; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."workflow_publication_trigger_status" ("workflowId", "nodeId", "versionId", "status", "errorMessage", "createdAt", "updatedAt", "triggerKind") FROM stdin;
\.


--
-- Data for Name: workflow_publish_history; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."workflow_publish_history" ("id", "workflowId", "versionId", "event", "userId", "createdAt") FROM stdin;
1	1AzpEC2wr7qj2qDP	02a02cd5-1e42-4fd5-a557-9deda19f620d	activated	d661e0bc-24f7-4347-a9ad-ba60de14eecb	2026-07-25 09:57:05.57+00
2	1AzpEC2wr7qj2qDP	02a02cd5-1e42-4fd5-a557-9deda19f620d	deactivated	d661e0bc-24f7-4347-a9ad-ba60de14eecb	2026-07-25 11:58:29.099+00
\.


--
-- Data for Name: workflow_statistics; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."workflow_statistics" ("count", "latestEvent", "name", "workflowId", "rootCount", "id", "workflowName") FROM stdin;
3	2026-07-25 09:38:04.001+00	manual_error	1AzpEC2wr7qj2qDP	0	3	My workflow
1	2026-07-25 09:51:02.894+00	data_loaded	1AzpEC2wr7qj2qDP	1	6	\N
4	2026-07-25 09:51:15.847+00	manual_success	1AzpEC2wr7qj2qDP	0	1	My workflow
4	2026-07-25 11:30:42.027+00	production_success	1AzpEC2wr7qj2qDP	4	9	My workflow
\.


--
-- Data for Name: workflow_statistics_delta; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."workflow_statistics_delta" ("id", "workflowId", "name", "rootCountDelta", "createdAt", "workflowName") FROM stdin;
\.


--
-- Data for Name: workflows_tags; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."workflows_tags" ("workflowId", "tagId") FROM stdin;
\.


--
-- Data for Name: buckets; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY "storage"."buckets" ("id", "name", "owner", "created_at", "updated_at", "public", "avif_autodetection", "file_size_limit", "allowed_mime_types", "owner_id", "type") FROM stdin;
\.


--
-- Data for Name: buckets_analytics; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY "storage"."buckets_analytics" ("name", "type", "format", "created_at", "updated_at", "id", "deleted_at") FROM stdin;
\.


--
-- Data for Name: buckets_vectors; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY "storage"."buckets_vectors" ("id", "type", "created_at", "updated_at") FROM stdin;
\.


--
-- Data for Name: objects; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY "storage"."objects" ("id", "bucket_id", "name", "owner", "created_at", "updated_at", "last_accessed_at", "metadata", "version", "owner_id", "user_metadata") FROM stdin;
\.


--
-- Data for Name: s3_multipart_uploads; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY "storage"."s3_multipart_uploads" ("id", "in_progress_size", "upload_signature", "bucket_id", "key", "version", "owner_id", "created_at", "user_metadata", "metadata") FROM stdin;
\.


--
-- Data for Name: s3_multipart_uploads_parts; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY "storage"."s3_multipart_uploads_parts" ("id", "upload_id", "size", "part_number", "bucket_id", "key", "etag", "owner_id", "version", "created_at") FROM stdin;
\.


--
-- Data for Name: vector_indexes; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY "storage"."vector_indexes" ("id", "name", "bucket_id", "data_type", "dimension", "distance_metric", "metadata_configuration", "created_at", "updated_at") FROM stdin;
\.


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: supabase_auth_admin
--

SELECT pg_catalog.setval('"auth"."refresh_tokens_id_seq"', 1, false);


--
-- Name: auth_provider_sync_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."auth_provider_sync_history_id_seq"', 1, false);


--
-- Name: credential_dependency_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."credential_dependency_id_seq"', 1, false);


--
-- Name: execution_annotations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."execution_annotations_id_seq"', 1, false);


--
-- Name: execution_entity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."execution_entity_id_seq"', 11, true);


--
-- Name: execution_metadata_temp_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."execution_metadata_temp_id_seq"', 1, false);


--
-- Name: insights_by_period_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."insights_by_period_id_seq"', 6, true);


--
-- Name: insights_metadata_metaId_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."insights_metadata_metaId_seq"', 1, true);


--
-- Name: insights_raw_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."insights_raw_id_seq"', 12, true);


--
-- Name: instance_version_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."instance_version_history_id_seq"', 1, true);


--
-- Name: migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."migrations_id_seq"', 222, true);


--
-- Name: oauth_user_consents_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."oauth_user_consents_id_seq"', 1, false);


--
-- Name: scheduled_job_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."scheduled_job_id_seq"', 1, false);


--
-- Name: scheduled_task_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."scheduled_task_id_seq"', 1, false);


--
-- Name: secrets_provider_connection_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."secrets_provider_connection_id_seq"', 1, false);


--
-- Name: user_favorites_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."user_favorites_id_seq"', 1, false);


--
-- Name: workflow_dependency_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."workflow_dependency_id_seq"', 43, true);


--
-- Name: workflow_publication_outbox_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."workflow_publication_outbox_id_seq"', 1, false);


--
-- Name: workflow_publish_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."workflow_publish_history_id_seq"', 2, true);


--
-- Name: workflow_statistics_delta_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."workflow_statistics_delta_id_seq"', 11, true);


--
-- Name: workflow_statistics_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."workflow_statistics_id_seq"', 12, true);


--
-- PostgreSQL database dump complete
--

-- \unrestrict QYBFhmgghjNqEOXWTbmQAnQlo5t3C4ok5bhhmcj5n66fjP32staidrb11u6iR2P

RESET ALL;
