


SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;


COMMENT ON SCHEMA "public" IS 'standard public schema';



CREATE EXTENSION IF NOT EXISTS "pg_stat_statements" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "pgcrypto" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "supabase_vault" WITH SCHEMA "vault";






CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA "extensions";






CREATE OR REPLACE FUNCTION "public"."increment_workflow_version"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
			BEGIN
				IF NEW."versionCounter" IS NOT DISTINCT FROM OLD."versionCounter"
					AND (NEW."nodes"::text IS DISTINCT FROM OLD."nodes"::text
						OR NEW."settings"::text IS DISTINCT FROM OLD."settings"::text) THEN
					NEW."versionCounter" = OLD."versionCounter" + 1;
				END IF;
				RETURN NEW;
			END;
			$$;


ALTER FUNCTION "public"."increment_workflow_version"() OWNER TO "postgres";

SET default_tablespace = '';

SET default_table_access_method = "heap";


CREATE TABLE IF NOT EXISTS "public"."agent_chat_subscriptions" (
    "agentId" character varying(36) NOT NULL,
    "integrationType" character varying(64) NOT NULL,
    "credentialId" character varying(255) NOT NULL,
    "threadId" character varying(255) NOT NULL,
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    CONSTRAINT "CHK_agent_chat_subscriptions_integrationType" CHECK ((("integrationType")::"text" = ANY ((ARRAY['telegram'::character varying, 'slack'::character varying, 'linear'::character varying])::"text"[])))
);


ALTER TABLE "public"."agent_chat_subscriptions" OWNER TO "postgres";


COMMENT ON COLUMN "public"."agent_chat_subscriptions"."agentId" IS 'Agent that owns this subscription';



COMMENT ON COLUMN "public"."agent_chat_subscriptions"."integrationType" IS 'Chat integration platform for this subscription';



COMMENT ON COLUMN "public"."agent_chat_subscriptions"."credentialId" IS 'Credential connection that owns this subscription';



COMMENT ON COLUMN "public"."agent_chat_subscriptions"."threadId" IS 'Platform thread ID the agent is subscribed to';



CREATE TABLE IF NOT EXISTS "public"."agent_checkpoints" (
    "runId" character varying(255) NOT NULL,
    "agentId" character varying(255),
    "state" "text",
    "expired" boolean DEFAULT false NOT NULL,
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL
);


ALTER TABLE "public"."agent_checkpoints" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."agent_execution" (
    "id" character varying(36) NOT NULL,
    "threadId" character varying(128) NOT NULL,
    "status" character varying(16) NOT NULL,
    "startedAt" timestamp(3) with time zone,
    "stoppedAt" timestamp(3) with time zone,
    "duration" integer DEFAULT 0 NOT NULL,
    "userMessage" "text",
    "model" character varying(255),
    "promptTokens" integer,
    "completionTokens" integer,
    "totalTokens" integer,
    "cost" double precision,
    "timeline" json,
    "error" "text",
    "hitlStatus" character varying(16),
    "source" character varying(32),
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    CONSTRAINT "CHK_agent_execution_hitlStatus" CHECK ((("hitlStatus")::"text" = ANY ((ARRAY['suspended'::character varying, 'resumed'::character varying])::"text"[]))),
    CONSTRAINT "CHK_agent_execution_status" CHECK ((("status")::"text" = ANY ((ARRAY['success'::character varying, 'error'::character varying])::"text"[])))
);


ALTER TABLE "public"."agent_execution" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."agent_execution_threads" (
    "id" character varying(128) NOT NULL,
    "agentId" character varying(36) NOT NULL,
    "agentName" character varying(255) NOT NULL,
    "projectId" character varying(255) NOT NULL,
    "sessionNumber" integer DEFAULT 0 NOT NULL,
    "totalPromptTokens" integer DEFAULT 0 NOT NULL,
    "totalCompletionTokens" integer DEFAULT 0 NOT NULL,
    "totalCost" double precision DEFAULT 0 NOT NULL,
    "totalDuration" integer DEFAULT 0 NOT NULL,
    "title" character varying(255),
    "emoji" character varying(8),
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "taskId" character varying(32),
    "taskVersionId" character varying(36),
    "parentThreadId" character varying(128),
    "parentAgentId" character varying(36)
);


ALTER TABLE "public"."agent_execution_threads" OWNER TO "postgres";


COMMENT ON COLUMN "public"."agent_execution_threads"."taskId" IS 'Published task ID that triggered this session; not an FK because published runs can outlive draft task definition rows';



COMMENT ON COLUMN "public"."agent_execution_threads"."taskVersionId" IS 'Published agent_history version that supplied the task snapshot';



COMMENT ON COLUMN "public"."agent_execution_threads"."parentThreadId" IS 'Parent session thread id that delegated this subagent run.';



COMMENT ON COLUMN "public"."agent_execution_threads"."parentAgentId" IS 'Saved agent id of the parent that delegated this subagent run.';



CREATE TABLE IF NOT EXISTS "public"."agent_files" (
    "id" character varying(16) NOT NULL,
    "agentId" character varying(36) NOT NULL,
    "binaryDataId" "text" NOT NULL,
    "fileName" character varying(255) NOT NULL,
    "mimeType" character varying(255) NOT NULL,
    "fileSizeBytes" integer NOT NULL,
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL
);


ALTER TABLE "public"."agent_files" OWNER TO "postgres";


COMMENT ON COLUMN "public"."agent_files"."id" IS 'Application-generated n8n nano ID';



COMMENT ON COLUMN "public"."agent_files"."agentId" IS 'Agent that owns this uploaded file';



COMMENT ON COLUMN "public"."agent_files"."binaryDataId" IS 'Opaque BinaryDataService reference (mode-prefixed, e.g. "filesystem-v2:<uuid>"); not an FK to binary_data, which only has rows in DB storage mode';



COMMENT ON COLUMN "public"."agent_files"."fileSizeBytes" IS 'Uploaded file size in bytes';



CREATE TABLE IF NOT EXISTS "public"."agent_history" (
    "versionId" character varying(36) NOT NULL,
    "agentId" character varying(36) NOT NULL,
    "schema" json,
    "tools" json,
    "skills" json,
    "publishedById" "uuid",
    "author" character varying(255) NOT NULL,
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL
);


ALTER TABLE "public"."agent_history" OWNER TO "postgres";


COMMENT ON COLUMN "public"."agent_history"."schema" IS 'Frozen snapshot of the published AgentJsonConfig';



COMMENT ON COLUMN "public"."agent_history"."tools" IS 'Frozen map of `toolId → { code, descriptor }` at publish time';



COMMENT ON COLUMN "public"."agent_history"."skills" IS 'Frozen map of `skillId → AgentSkill` at publish time';



CREATE TABLE IF NOT EXISTS "public"."agent_task_definition" (
    "id" character varying(32) NOT NULL,
    "agentId" character varying(36) NOT NULL,
    "name" character varying(128) NOT NULL,
    "objective" "text" NOT NULL,
    "cronExpression" character varying(128) NOT NULL,
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL
);


ALTER TABLE "public"."agent_task_definition" OWNER TO "postgres";


COMMENT ON COLUMN "public"."agent_task_definition"."id" IS 'Application-generated task ID referenced from agent JSON config';



COMMENT ON COLUMN "public"."agent_task_definition"."agentId" IS 'Owning agent; task definitions are deleted when the agent is deleted';



COMMENT ON COLUMN "public"."agent_task_definition"."objective" IS 'User-authored instruction sent to the agent when this task runs';



COMMENT ON COLUMN "public"."agent_task_definition"."cronExpression" IS 'Cron schedule evaluated using the instance timezone';



CREATE TABLE IF NOT EXISTS "public"."agent_task_run_lock" (
    "agentId" character varying(36) NOT NULL,
    "taskId" character varying(32) NOT NULL,
    "holderId" "uuid" NOT NULL,
    "heldUntil" timestamp(3) with time zone NOT NULL,
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL
);


ALTER TABLE "public"."agent_task_run_lock" OWNER TO "postgres";


COMMENT ON COLUMN "public"."agent_task_run_lock"."agentId" IS 'Published agent whose scheduled task run is locked';



COMMENT ON COLUMN "public"."agent_task_run_lock"."taskId" IS 'Published task ID whose scheduled run is locked';



COMMENT ON COLUMN "public"."agent_task_run_lock"."holderId" IS 'Ephemeral lock owner token generated by the running main';



COMMENT ON COLUMN "public"."agent_task_run_lock"."heldUntil" IS 'Time after which another main can claim this task run lock';



CREATE TABLE IF NOT EXISTS "public"."agent_task_snapshot" (
    "versionId" character varying(36) NOT NULL,
    "taskId" character varying(32) NOT NULL,
    "enabled" boolean NOT NULL,
    "name" character varying(128) NOT NULL,
    "objective" "text" NOT NULL,
    "cronExpression" character varying(128) NOT NULL,
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL
);


ALTER TABLE "public"."agent_task_snapshot" OWNER TO "postgres";


COMMENT ON COLUMN "public"."agent_task_snapshot"."versionId" IS 'Published agent_history version this task snapshot belongs to';



COMMENT ON COLUMN "public"."agent_task_snapshot"."taskId" IS 'Stable task ID referenced from the published agent JSON config';



COMMENT ON COLUMN "public"."agent_task_snapshot"."enabled" IS 'Published enabled state for this task at publish time';



COMMENT ON COLUMN "public"."agent_task_snapshot"."objective" IS 'User-authored instruction sent to the agent when this task runs';



COMMENT ON COLUMN "public"."agent_task_snapshot"."cronExpression" IS 'Cron schedule evaluated using the instance timezone';



CREATE TABLE IF NOT EXISTS "public"."agents" (
    "id" character varying(36) NOT NULL,
    "name" character varying(128) NOT NULL,
    "projectId" character varying(255) NOT NULL,
    "integrations" json DEFAULT '[]'::json NOT NULL,
    "schema" json,
    "tools" json DEFAULT '{}'::json NOT NULL,
    "skills" json DEFAULT '{}'::json NOT NULL,
    "versionId" character varying(36),
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "activeVersionId" character varying(36)
);


ALTER TABLE "public"."agents" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."agents_memory_entries" (
    "id" character varying(36) NOT NULL,
    "agentId" character varying(36) NOT NULL,
    "resourceId" character varying(255) NOT NULL,
    "content" "text" NOT NULL,
    "contentHash" character varying(64) NOT NULL,
    "status" character varying(16) NOT NULL,
    "supersededBy" character varying(36),
    "embeddingModel" character varying(128),
    "embedding" json,
    "metadata" json,
    "lastSeenAt" timestamp(3) with time zone NOT NULL,
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    CONSTRAINT "CHK_agents_memory_entries_status" CHECK ((("status")::"text" = ANY ((ARRAY['active'::character varying, 'superseded'::character varying, 'dropped'::character varying])::"text"[])))
);


ALTER TABLE "public"."agents_memory_entries" OWNER TO "postgres";


COMMENT ON COLUMN "public"."agents_memory_entries"."agentId" IS 'Agent that owns this episodic memory entry';



COMMENT ON COLUMN "public"."agents_memory_entries"."resourceId" IS 'agents_resources.id partition used for episodic recall scope';



COMMENT ON COLUMN "public"."agents_memory_entries"."supersededBy" IS 'Self-reference to replacement memory entry';



COMMENT ON COLUMN "public"."agents_memory_entries"."embeddingModel" IS 'Embedding model used to produce embedding';



COMMENT ON COLUMN "public"."agents_memory_entries"."embedding" IS 'Embedding vector for episodic recall';



COMMENT ON COLUMN "public"."agents_memory_entries"."metadata" IS 'Optional system metadata for ranking and debugging';



COMMENT ON COLUMN "public"."agents_memory_entries"."lastSeenAt" IS 'Last time equivalent content was observed; updatedAt tracks row mutation time';



CREATE TABLE IF NOT EXISTS "public"."agents_memory_entry_cursors" (
    "agentId" character varying(36) NOT NULL,
    "observationScopeId" character varying(255) NOT NULL,
    "lastIndexedObservationId" character varying(36) NOT NULL,
    "lastIndexedObservationCreatedAt" timestamp(3) with time zone NOT NULL,
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL
);


ALTER TABLE "public"."agents_memory_entry_cursors" OWNER TO "postgres";


COMMENT ON COLUMN "public"."agents_memory_entry_cursors"."agentId" IS 'Agent that owns this cursor';



COMMENT ON COLUMN "public"."agents_memory_entry_cursors"."observationScopeId" IS 'agents_threads.id source stream indexed into episodic memory';



COMMENT ON COLUMN "public"."agents_memory_entry_cursors"."lastIndexedObservationId" IS 'Last observation-log row indexed into episodic memory';



COMMENT ON COLUMN "public"."agents_memory_entry_cursors"."lastIndexedObservationCreatedAt" IS 'Creation timestamp for the last indexed observation-log row';



CREATE TABLE IF NOT EXISTS "public"."agents_memory_entry_locks" (
    "agentId" character varying(36) NOT NULL,
    "resourceId" character varying(255) NOT NULL,
    "holderId" character varying(64) NOT NULL,
    "heldUntil" timestamp(3) with time zone NOT NULL,
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL
);


ALTER TABLE "public"."agents_memory_entry_locks" OWNER TO "postgres";


COMMENT ON COLUMN "public"."agents_memory_entry_locks"."agentId" IS 'Agent that owns this lock';



COMMENT ON COLUMN "public"."agents_memory_entry_locks"."resourceId" IS 'agents_resources.id partition locked for episodic indexing';



COMMENT ON COLUMN "public"."agents_memory_entry_locks"."holderId" IS 'Ephemeral background-task lock owner token';



CREATE TABLE IF NOT EXISTS "public"."agents_memory_entry_sources" (
    "id" character varying(36) NOT NULL,
    "agentId" character varying(36) NOT NULL,
    "memoryEntryId" character varying(36) NOT NULL,
    "observationId" character varying(36) NOT NULL,
    "threadId" character varying(255) NOT NULL,
    "evidenceHash" character varying(64) NOT NULL,
    "evidenceText" "text" NOT NULL,
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL
);


ALTER TABLE "public"."agents_memory_entry_sources" OWNER TO "postgres";


COMMENT ON COLUMN "public"."agents_memory_entry_sources"."agentId" IS 'Agent that owns the linked episodic memory entry source';



COMMENT ON COLUMN "public"."agents_memory_entry_sources"."memoryEntryId" IS 'Episodic memory entry linked to this source evidence';



COMMENT ON COLUMN "public"."agents_memory_entry_sources"."observationId" IS 'Observation-log row used as source evidence';



COMMENT ON COLUMN "public"."agents_memory_entry_sources"."threadId" IS 'Source conversation thread that produced the linked observation';



COMMENT ON COLUMN "public"."agents_memory_entry_sources"."evidenceHash" IS 'Bounded hash used to deduplicate exact evidence links';



COMMENT ON COLUMN "public"."agents_memory_entry_sources"."evidenceText" IS 'Exact source evidence text from the observation, not recall scope';



CREATE TABLE IF NOT EXISTS "public"."agents_messages" (
    "id" character varying(36) NOT NULL,
    "threadId" character varying(255) NOT NULL,
    "resourceId" character varying(255) NOT NULL,
    "role" character varying(36) NOT NULL,
    "type" character varying(36),
    "content" json NOT NULL,
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL
);


ALTER TABLE "public"."agents_messages" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."agents_observation_cursors" (
    "agentId" character varying(36) NOT NULL,
    "observationScopeId" character varying(255) NOT NULL,
    "lastObservedMessageId" character varying(36) NOT NULL,
    "lastObservedAt" timestamp(3) with time zone NOT NULL,
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL
);


ALTER TABLE "public"."agents_observation_cursors" OWNER TO "postgres";


COMMENT ON COLUMN "public"."agents_observation_cursors"."agentId" IS 'Agent that owns this cursor';



COMMENT ON COLUMN "public"."agents_observation_cursors"."observationScopeId" IS 'agents_threads.id source stream checkpointed by this cursor';



CREATE TABLE IF NOT EXISTS "public"."agents_observation_locks" (
    "agentId" character varying(36) NOT NULL,
    "observationScopeId" character varying(255) NOT NULL,
    "taskKind" character varying(20) NOT NULL,
    "holderId" character varying(64) NOT NULL,
    "heldUntil" timestamp(3) with time zone NOT NULL,
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    CONSTRAINT "CHK_agents_observation_locks_taskKind" CHECK ((("taskKind")::"text" = ANY ((ARRAY['observer'::character varying, 'reflector'::character varying])::"text"[])))
);


ALTER TABLE "public"."agents_observation_locks" OWNER TO "postgres";


COMMENT ON COLUMN "public"."agents_observation_locks"."agentId" IS 'Agent that owns this lock';



COMMENT ON COLUMN "public"."agents_observation_locks"."observationScopeId" IS 'agents_threads.id source stream locked for observation tasks';



COMMENT ON COLUMN "public"."agents_observation_locks"."holderId" IS 'Ephemeral background-task lock owner token, not a user ID';



CREATE TABLE IF NOT EXISTS "public"."agents_observations" (
    "id" character varying(36) NOT NULL,
    "agentId" character varying(36) NOT NULL,
    "observationScopeId" character varying(255) NOT NULL,
    "marker" character varying(16) NOT NULL,
    "text" "text" NOT NULL,
    "parentId" character varying(36),
    "tokenCount" integer DEFAULT 0 NOT NULL,
    "status" character varying(16) NOT NULL,
    "supersededBy" character varying(36),
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    CONSTRAINT "CHK_agents_observations_marker" CHECK ((("marker")::"text" = ANY ((ARRAY['critical'::character varying, 'important'::character varying, 'info'::character varying, 'completion'::character varying])::"text"[]))),
    CONSTRAINT "CHK_agents_observations_status" CHECK ((("status")::"text" = ANY ((ARRAY['active'::character varying, 'superseded'::character varying, 'dropped'::character varying])::"text"[])))
);


ALTER TABLE "public"."agents_observations" OWNER TO "postgres";


COMMENT ON COLUMN "public"."agents_observations"."id" IS 'Application-generated n8n string ID, not a database UUID';



COMMENT ON COLUMN "public"."agents_observations"."agentId" IS 'Agent that owns this observation row';



COMMENT ON COLUMN "public"."agents_observations"."observationScopeId" IS 'agents_threads.id source stream for this observation log';



CREATE TABLE IF NOT EXISTS "public"."agents_resources" (
    "id" character varying(255) NOT NULL,
    "metadata" "text",
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL
);


ALTER TABLE "public"."agents_resources" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."agents_threads" (
    "id" character varying(128) NOT NULL,
    "resourceId" character varying(255) NOT NULL,
    "title" character varying(255),
    "metadata" "text",
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL
);


ALTER TABLE "public"."agents_threads" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."ai_builder_temporary_workflow" (
    "workflowId" character varying(36) NOT NULL,
    "threadId" "uuid" NOT NULL,
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL
);


ALTER TABLE "public"."ai_builder_temporary_workflow" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."annotation_tag_entity" (
    "id" character varying(16) NOT NULL,
    "name" character varying(24) NOT NULL,
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL
);


ALTER TABLE "public"."annotation_tag_entity" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."auth_identity" (
    "userId" "uuid",
    "providerId" character varying(255) NOT NULL,
    "providerType" character varying(32) NOT NULL,
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL
);


ALTER TABLE "public"."auth_identity" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."auth_provider_sync_history" (
    "id" integer NOT NULL,
    "providerType" character varying(32) NOT NULL,
    "runMode" "text" NOT NULL,
    "status" "text" NOT NULL,
    "startedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "endedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "scanned" integer NOT NULL,
    "created" integer NOT NULL,
    "updated" integer NOT NULL,
    "disabled" integer NOT NULL,
    "error" "text"
);


ALTER TABLE "public"."auth_provider_sync_history" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "public"."auth_provider_sync_history_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "public"."auth_provider_sync_history_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."auth_provider_sync_history_id_seq" OWNED BY "public"."auth_provider_sync_history"."id";



CREATE TABLE IF NOT EXISTS "public"."binary_data" (
    "fileId" "uuid" NOT NULL,
    "sourceType" character varying(50) NOT NULL,
    "sourceId" character varying(255) NOT NULL,
    "data" "bytea" NOT NULL,
    "mimeType" character varying(255),
    "fileName" character varying(255),
    "fileSize" integer NOT NULL,
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    CONSTRAINT "CHK_binary_data_sourceType" CHECK ((("sourceType")::"text" = ANY ((ARRAY['execution'::character varying, 'chat_message_attachment'::character varying, 'agent_file'::character varying])::"text"[])))
);


ALTER TABLE "public"."binary_data" OWNER TO "postgres";


COMMENT ON COLUMN "public"."binary_data"."sourceType" IS 'Source the file belongs to, e.g. ''execution''';



COMMENT ON COLUMN "public"."binary_data"."sourceId" IS 'ID of the source, e.g. execution ID';



COMMENT ON COLUMN "public"."binary_data"."data" IS 'Raw, not base64 encoded';



COMMENT ON COLUMN "public"."binary_data"."fileSize" IS 'In bytes';



CREATE TABLE IF NOT EXISTS "public"."chat_hub_agent_tools" (
    "agentId" "uuid" NOT NULL,
    "toolId" "uuid" NOT NULL
);


ALTER TABLE "public"."chat_hub_agent_tools" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."chat_hub_agents" (
    "id" "uuid" NOT NULL,
    "name" character varying(256) NOT NULL,
    "description" character varying(512),
    "systemPrompt" "text" NOT NULL,
    "ownerId" "uuid" NOT NULL,
    "credentialId" character varying(36),
    "provider" character varying(16) NOT NULL,
    "model" character varying(64) NOT NULL,
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "icon" json,
    "files" json DEFAULT '[]'::json NOT NULL,
    "suggestedPrompts" json DEFAULT '[]'::json NOT NULL
);


ALTER TABLE "public"."chat_hub_agents" OWNER TO "postgres";


COMMENT ON COLUMN "public"."chat_hub_agents"."provider" IS 'ChatHubProvider enum: "openai", "anthropic", "google", "n8n"';



COMMENT ON COLUMN "public"."chat_hub_agents"."model" IS 'Model name used at the respective Model node, ie. "gpt-4"';



CREATE TABLE IF NOT EXISTS "public"."chat_hub_messages" (
    "id" "uuid" NOT NULL,
    "sessionId" "uuid" NOT NULL,
    "previousMessageId" "uuid",
    "revisionOfMessageId" "uuid",
    "retryOfMessageId" "uuid",
    "type" character varying(16) NOT NULL,
    "name" character varying(128) NOT NULL,
    "content" "text" NOT NULL,
    "provider" character varying(16),
    "model" character varying(256),
    "workflowId" character varying(36),
    "executionId" integer,
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "agentId" "uuid",
    "status" character varying(16) DEFAULT 'success'::character varying NOT NULL,
    "attachments" json
);


ALTER TABLE "public"."chat_hub_messages" OWNER TO "postgres";


COMMENT ON COLUMN "public"."chat_hub_messages"."type" IS 'ChatHubMessageType enum: "human", "ai", "system", "tool", "generic"';



COMMENT ON COLUMN "public"."chat_hub_messages"."provider" IS 'ChatHubProvider enum: "openai", "anthropic", "google", "n8n"';



COMMENT ON COLUMN "public"."chat_hub_messages"."model" IS 'Model name used at the respective Model node, ie. "gpt-4"';



COMMENT ON COLUMN "public"."chat_hub_messages"."agentId" IS 'ID of the custom agent (if provider is "custom-agent")';



COMMENT ON COLUMN "public"."chat_hub_messages"."status" IS 'ChatHubMessageStatus enum, eg. "success", "error", "running", "cancelled"';



COMMENT ON COLUMN "public"."chat_hub_messages"."attachments" IS 'File attachments for the message (if any), stored as JSON. Files are stored as base64-encoded data URLs.';



CREATE TABLE IF NOT EXISTS "public"."chat_hub_session_tools" (
    "sessionId" "uuid" NOT NULL,
    "toolId" "uuid" NOT NULL
);


ALTER TABLE "public"."chat_hub_session_tools" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."chat_hub_sessions" (
    "id" "uuid" NOT NULL,
    "title" character varying(256) NOT NULL,
    "ownerId" "uuid" NOT NULL,
    "lastMessageAt" timestamp(3) with time zone NOT NULL,
    "credentialId" character varying(36),
    "provider" character varying(16),
    "model" character varying(256),
    "workflowId" character varying(36),
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "agentId" "uuid",
    "agentName" character varying(128),
    "type" character varying(16) DEFAULT 'production'::character varying NOT NULL,
    CONSTRAINT "CHK_chat_hub_sessions_type" CHECK ((("type")::"text" = ANY ((ARRAY['production'::character varying, 'manual'::character varying])::"text"[])))
);


ALTER TABLE "public"."chat_hub_sessions" OWNER TO "postgres";


COMMENT ON COLUMN "public"."chat_hub_sessions"."provider" IS 'ChatHubProvider enum: "openai", "anthropic", "google", "n8n"';



COMMENT ON COLUMN "public"."chat_hub_sessions"."model" IS 'Model name used at the respective Model node, ie. "gpt-4"';



COMMENT ON COLUMN "public"."chat_hub_sessions"."agentId" IS 'ID of the custom agent (if provider is "custom-agent")';



COMMENT ON COLUMN "public"."chat_hub_sessions"."agentName" IS 'Cached name of the custom agent (if provider is "custom-agent")';



CREATE TABLE IF NOT EXISTS "public"."chat_hub_tools" (
    "id" "uuid" NOT NULL,
    "name" character varying(255) NOT NULL,
    "type" character varying(255) NOT NULL,
    "typeVersion" double precision NOT NULL,
    "ownerId" "uuid" NOT NULL,
    "definition" json NOT NULL,
    "enabled" boolean DEFAULT true NOT NULL,
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL
);


ALTER TABLE "public"."chat_hub_tools" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."credential_dependency" (
    "id" integer NOT NULL,
    "credentialId" character varying(36) NOT NULL,
    "dependencyType" character varying(64) NOT NULL,
    "dependencyId" character varying(255) NOT NULL,
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL
);


ALTER TABLE "public"."credential_dependency" OWNER TO "postgres";


ALTER TABLE "public"."credential_dependency" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."credential_dependency_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."credentials_entity" (
    "name" character varying(128) NOT NULL,
    "data" "text" NOT NULL,
    "type" character varying(128) NOT NULL,
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "id" character varying(36) NOT NULL,
    "isManaged" boolean DEFAULT false NOT NULL,
    "isGlobal" boolean DEFAULT false NOT NULL,
    "isResolvable" boolean DEFAULT false NOT NULL,
    "resolvableAllowFallback" boolean DEFAULT false NOT NULL,
    "resolverId" character varying(16)
);


ALTER TABLE "public"."credentials_entity" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."data_table" (
    "id" character varying(36) NOT NULL,
    "name" character varying(128) NOT NULL,
    "projectId" character varying(36) NOT NULL,
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL
);


ALTER TABLE "public"."data_table" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."data_table_column" (
    "id" character varying(36) NOT NULL,
    "name" character varying(128) NOT NULL,
    "type" character varying(32) NOT NULL,
    "index" integer NOT NULL,
    "dataTableId" character varying(36) NOT NULL,
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL
);


ALTER TABLE "public"."data_table_column" OWNER TO "postgres";


COMMENT ON COLUMN "public"."data_table_column"."type" IS 'Expected: string, number, boolean, or date (not enforced as a constraint)';



COMMENT ON COLUMN "public"."data_table_column"."index" IS 'Column order, starting from 0 (0 = first column)';



CREATE TABLE IF NOT EXISTS "public"."deployment_key" (
    "id" character varying(36) NOT NULL,
    "type" character varying(64) NOT NULL,
    "value" "text" NOT NULL,
    "algorithm" character varying(20),
    "status" character varying(20) NOT NULL,
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL
);


ALTER TABLE "public"."deployment_key" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."dynamic_credential_entry" (
    "credential_id" character varying(16) NOT NULL,
    "subject_id" character varying(2048) NOT NULL,
    "resolver_id" character varying(16) NOT NULL,
    "data" "text" NOT NULL,
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL
);


ALTER TABLE "public"."dynamic_credential_entry" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."dynamic_credential_resolver" (
    "id" character varying(16) NOT NULL,
    "name" character varying(128) NOT NULL,
    "type" character varying(128) NOT NULL,
    "config" "text" NOT NULL,
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL
);


ALTER TABLE "public"."dynamic_credential_resolver" OWNER TO "postgres";


COMMENT ON COLUMN "public"."dynamic_credential_resolver"."config" IS 'Encrypted resolver configuration (JSON encrypted as string)';



CREATE TABLE IF NOT EXISTS "public"."dynamic_credential_user_entry" (
    "credentialId" character varying(16) NOT NULL,
    "userId" "uuid" NOT NULL,
    "resolverId" character varying(16) NOT NULL,
    "data" "text" NOT NULL,
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL
);


ALTER TABLE "public"."dynamic_credential_user_entry" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."evaluation_collection" (
    "id" character varying(36) NOT NULL,
    "name" character varying(128) NOT NULL,
    "description" "text",
    "workflowId" character varying(36) NOT NULL,
    "evaluationConfigId" character varying(36) NOT NULL,
    "createdById" "uuid",
    "insightsCache" json,
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL
);


ALTER TABLE "public"."evaluation_collection" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."evaluation_config" (
    "id" character varying(36) NOT NULL,
    "workflowId" character varying(36) NOT NULL,
    "name" character varying(128) NOT NULL,
    "status" character varying(16) DEFAULT 'valid'::character varying NOT NULL,
    "invalidReason" character varying(64),
    "datasetSource" character varying(32) NOT NULL,
    "datasetRef" json NOT NULL,
    "startNodeName" character varying(255) NOT NULL,
    "endNodeName" character varying(255) NOT NULL,
    "metrics" json NOT NULL,
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL
);


ALTER TABLE "public"."evaluation_config" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."event_destinations" (
    "id" "uuid" NOT NULL,
    "destination" "jsonb" NOT NULL,
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL
);


ALTER TABLE "public"."event_destinations" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."execution_annotation_tags" (
    "annotationId" integer NOT NULL,
    "tagId" character varying(24) NOT NULL
);


ALTER TABLE "public"."execution_annotation_tags" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."execution_annotations" (
    "id" integer NOT NULL,
    "executionId" integer NOT NULL,
    "vote" character varying(6),
    "note" "text",
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL
);


ALTER TABLE "public"."execution_annotations" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "public"."execution_annotations_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "public"."execution_annotations_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."execution_annotations_id_seq" OWNED BY "public"."execution_annotations"."id";



CREATE TABLE IF NOT EXISTS "public"."execution_data" (
    "executionId" integer NOT NULL,
    "workflowData" json NOT NULL,
    "data" "text" NOT NULL,
    "workflowVersionId" character varying(36)
);


ALTER TABLE "public"."execution_data" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."execution_entity" (
    "id" integer NOT NULL,
    "finished" boolean NOT NULL,
    "mode" character varying NOT NULL,
    "retryOf" character varying,
    "retrySuccessId" character varying,
    "startedAt" timestamp(3) with time zone,
    "stoppedAt" timestamp(3) with time zone,
    "waitTill" timestamp(3) with time zone,
    "status" character varying NOT NULL,
    "workflowId" character varying(36) NOT NULL,
    "deletedAt" timestamp(3) with time zone,
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "storedAt" character varying(2) DEFAULT 'db'::character varying NOT NULL,
    "tracingContext" json,
    "deduplicationKey" character varying(255),
    "jsonSizeBytes" bigint DEFAULT 0 NOT NULL,
    "workflowVersionId" character varying(36) DEFAULT NULL::character varying,
    "binaryDataSizeBytes" bigint DEFAULT 0 NOT NULL,
    "usedPrivateCredentials" boolean DEFAULT false NOT NULL,
    CONSTRAINT "CHK_execution_entity_storedAt" CHECK ((("storedAt")::"text" = ANY ((ARRAY['db'::character varying, 'fs'::character varying, 's3'::character varying, 'az'::character varying])::"text"[])))
);


ALTER TABLE "public"."execution_entity" OWNER TO "postgres";


COMMENT ON COLUMN "public"."execution_entity"."jsonSizeBytes" IS 'Byte size of the JSON execution data bundle (run data, workflow snapshot, version id); excludes binary data. 0 means unknown.';



COMMENT ON COLUMN "public"."execution_entity"."workflowVersionId" IS 'Version id of the workflow run by this execution; denormalized from the data bundle.';



COMMENT ON COLUMN "public"."execution_entity"."binaryDataSizeBytes" IS 'Byte size of binary data offloaded to separate storage (db/fs/S3), deduplicated by blob; excludes inline binary counted in jsonSizeBytes. 0 means unknown.';



COMMENT ON COLUMN "public"."execution_entity"."usedPrivateCredentials" IS 'Whether this execution ran with at least one dynamically-resolved private credential.';



CREATE SEQUENCE IF NOT EXISTS "public"."execution_entity_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "public"."execution_entity_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."execution_entity_id_seq" OWNED BY "public"."execution_entity"."id";



CREATE TABLE IF NOT EXISTS "public"."execution_metadata" (
    "id" integer NOT NULL,
    "executionId" integer NOT NULL,
    "key" character varying(255) NOT NULL,
    "value" "text" NOT NULL
);


ALTER TABLE "public"."execution_metadata" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "public"."execution_metadata_temp_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "public"."execution_metadata_temp_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."execution_metadata_temp_id_seq" OWNED BY "public"."execution_metadata"."id";



CREATE TABLE IF NOT EXISTS "public"."folder" (
    "id" character varying(36) NOT NULL,
    "name" character varying(128) NOT NULL,
    "parentFolderId" character varying(36),
    "projectId" character varying(36) NOT NULL,
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL
);


ALTER TABLE "public"."folder" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."folder_tag" (
    "folderId" character varying(36) NOT NULL,
    "tagId" character varying(36) NOT NULL
);


ALTER TABLE "public"."folder_tag" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."insights_by_period" (
    "id" integer NOT NULL,
    "metaId" integer NOT NULL,
    "type" integer NOT NULL,
    "value" bigint NOT NULL,
    "periodUnit" integer NOT NULL,
    "periodStart" timestamp(0) with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE "public"."insights_by_period" OWNER TO "postgres";


COMMENT ON COLUMN "public"."insights_by_period"."type" IS '0: time_saved_minutes, 1: runtime_milliseconds, 2: success, 3: failure';



COMMENT ON COLUMN "public"."insights_by_period"."periodUnit" IS '0: hour, 1: day, 2: week';



ALTER TABLE "public"."insights_by_period" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."insights_by_period_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."insights_metadata" (
    "metaId" integer NOT NULL,
    "workflowId" character varying(36),
    "projectId" character varying(36),
    "workflowName" character varying(128) NOT NULL,
    "projectName" character varying(255) NOT NULL
);


ALTER TABLE "public"."insights_metadata" OWNER TO "postgres";


ALTER TABLE "public"."insights_metadata" ALTER COLUMN "metaId" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."insights_metadata_metaId_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."insights_raw" (
    "id" integer NOT NULL,
    "metaId" integer NOT NULL,
    "type" integer NOT NULL,
    "value" bigint NOT NULL,
    "timestamp" timestamp(0) with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE "public"."insights_raw" OWNER TO "postgres";


COMMENT ON COLUMN "public"."insights_raw"."type" IS '0: time_saved_minutes, 1: runtime_milliseconds, 2: success, 3: failure';



ALTER TABLE "public"."insights_raw" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."insights_raw_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."installed_nodes" (
    "name" character varying(200) NOT NULL,
    "type" character varying(200) NOT NULL,
    "latestVersion" integer DEFAULT 1 NOT NULL,
    "package" character varying(241) NOT NULL
);


ALTER TABLE "public"."installed_nodes" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."installed_packages" (
    "packageName" character varying(214) NOT NULL,
    "installedVersion" character varying(50) NOT NULL,
    "authorName" character varying(70),
    "authorEmail" character varying(70),
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL
);


ALTER TABLE "public"."installed_packages" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."instance_ai_checkpoints" (
    "key" character varying(255) NOT NULL,
    "runId" character varying(255),
    "threadId" "uuid" NOT NULL,
    "resourceId" character varying(255),
    "state" json,
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "expiredAt" timestamp(3) with time zone,
    CONSTRAINT "instance_ai_checkpoints_state_tombstone_check" CHECK (((("expiredAt" IS NOT NULL) AND ("state" IS NULL)) OR ("expiredAt" IS NULL)))
);


ALTER TABLE "public"."instance_ai_checkpoints" OWNER TO "postgres";


COMMENT ON COLUMN "public"."instance_ai_checkpoints"."key" IS 'Opaque checkpoint key from the agent runtime.';



COMMENT ON COLUMN "public"."instance_ai_checkpoints"."runId" IS 'Run ID parsed from the checkpoint key when available.';



COMMENT ON COLUMN "public"."instance_ai_checkpoints"."threadId" IS 'Instance AI thread that owns the checkpoint.';



COMMENT ON COLUMN "public"."instance_ai_checkpoints"."resourceId" IS 'Resource ID recorded by the agent runtime.';



COMMENT ON COLUMN "public"."instance_ai_checkpoints"."state" IS 'Serializable agent state snapshot stored as JSON.';



COMMENT ON COLUMN "public"."instance_ai_checkpoints"."expiredAt" IS 'Soft-delete timestamp: null means live; non-null marks the row as a tombstone.';



CREATE TABLE IF NOT EXISTS "public"."instance_ai_iteration_logs" (
    "id" character varying(36) NOT NULL,
    "threadId" "uuid" NOT NULL,
    "taskKey" character varying NOT NULL,
    "entry" "text" NOT NULL,
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL
);


ALTER TABLE "public"."instance_ai_iteration_logs" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."instance_ai_mcp_registry_connections" (
    "id" "uuid" NOT NULL,
    "credentialId" character varying(36) NOT NULL,
    "serverSlug" character varying(255) NOT NULL,
    "toolFilter" json,
    "userId" "uuid" NOT NULL,
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL
);


ALTER TABLE "public"."instance_ai_mcp_registry_connections" OWNER TO "postgres";


COMMENT ON COLUMN "public"."instance_ai_mcp_registry_connections"."toolFilter" IS 'Optional MCP tool filter per registry connection: { mode: "allow" | "exclude", tools: string[] }';



CREATE TABLE IF NOT EXISTS "public"."instance_ai_messages" (
    "id" character varying(36) NOT NULL,
    "threadId" "uuid" NOT NULL,
    "content" "text" NOT NULL,
    "role" character varying(16) NOT NULL,
    "type" character varying(32),
    "resourceId" character varying(255),
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL
);


ALTER TABLE "public"."instance_ai_messages" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."instance_ai_observation_cursors" (
    "observationScopeId" "uuid" NOT NULL,
    "lastObservedMessageId" character varying(36) NOT NULL,
    "lastObservedAt" timestamp(3) with time zone NOT NULL,
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL
);


ALTER TABLE "public"."instance_ai_observation_cursors" OWNER TO "postgres";


COMMENT ON COLUMN "public"."instance_ai_observation_cursors"."observationScopeId" IS 'instance_ai_threads.id source stream checkpointed by this cursor';



CREATE TABLE IF NOT EXISTS "public"."instance_ai_observation_locks" (
    "observationScopeId" "uuid" NOT NULL,
    "taskKind" character varying(20) NOT NULL,
    "holderId" character varying(64) NOT NULL,
    "heldUntil" timestamp(3) with time zone NOT NULL,
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    CONSTRAINT "CHK_instance_ai_observation_locks_taskKind" CHECK ((("taskKind")::"text" = ANY ((ARRAY['observer'::character varying, 'reflector'::character varying])::"text"[])))
);


ALTER TABLE "public"."instance_ai_observation_locks" OWNER TO "postgres";


COMMENT ON COLUMN "public"."instance_ai_observation_locks"."observationScopeId" IS 'instance_ai_threads.id source stream locked for observation tasks';



COMMENT ON COLUMN "public"."instance_ai_observation_locks"."holderId" IS 'Ephemeral background-task lock owner token, not a user ID';



CREATE TABLE IF NOT EXISTS "public"."instance_ai_observational_memory" (
    "id" character varying(36) NOT NULL,
    "lookupKey" character varying(255) NOT NULL,
    "scope" character varying(16) NOT NULL,
    "threadId" "uuid",
    "resourceId" character varying(255) NOT NULL,
    "activeObservations" "text" DEFAULT ''::"text" NOT NULL,
    "originType" character varying(32) NOT NULL,
    "config" "text" NOT NULL,
    "generationCount" integer DEFAULT 0 NOT NULL,
    "lastObservedAt" timestamp(3) with time zone,
    "pendingMessageTokens" integer DEFAULT 0 NOT NULL,
    "totalTokensObserved" integer DEFAULT 0 NOT NULL,
    "observationTokenCount" integer DEFAULT 0 NOT NULL,
    "isObserving" boolean DEFAULT false NOT NULL,
    "isReflecting" boolean DEFAULT false NOT NULL,
    "observedMessageIds" json,
    "observedTimezone" character varying,
    "bufferedObservations" "text",
    "bufferedObservationTokens" integer,
    "bufferedMessageIds" json,
    "bufferedReflection" "text",
    "bufferedReflectionTokens" integer,
    "bufferedReflectionInputTokens" integer,
    "reflectedObservationLineCount" integer,
    "bufferedObservationChunks" json,
    "isBufferingObservation" boolean DEFAULT false NOT NULL,
    "isBufferingReflection" boolean DEFAULT false NOT NULL,
    "lastBufferedAtTokens" integer DEFAULT 0 NOT NULL,
    "lastBufferedAtTime" timestamp(3) with time zone,
    "metadata" json,
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL
);


ALTER TABLE "public"."instance_ai_observational_memory" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."instance_ai_observations" (
    "id" character varying(36) NOT NULL,
    "observationScopeId" "uuid" NOT NULL,
    "marker" character varying(16) NOT NULL,
    "text" "text" NOT NULL,
    "parentId" character varying(36),
    "tokenCount" integer DEFAULT 0 NOT NULL,
    "status" character varying(16) NOT NULL,
    "supersededBy" character varying(36),
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    CONSTRAINT "CHK_instance_ai_observations_marker" CHECK ((("marker")::"text" = ANY ((ARRAY['critical'::character varying, 'important'::character varying, 'info'::character varying, 'completion'::character varying])::"text"[]))),
    CONSTRAINT "CHK_instance_ai_observations_status" CHECK ((("status")::"text" = ANY ((ARRAY['active'::character varying, 'superseded'::character varying, 'dropped'::character varying])::"text"[])))
);


ALTER TABLE "public"."instance_ai_observations" OWNER TO "postgres";


COMMENT ON COLUMN "public"."instance_ai_observations"."id" IS 'Application-generated n8n string ID, not a database UUID';



COMMENT ON COLUMN "public"."instance_ai_observations"."observationScopeId" IS 'instance_ai_threads.id source stream for this observation log';



CREATE TABLE IF NOT EXISTS "public"."instance_ai_pending_confirmations" (
    "requestId" character varying(36) NOT NULL,
    "threadId" "uuid" NOT NULL,
    "userId" "uuid" NOT NULL,
    "kind" character varying(16) NOT NULL,
    "runId" character varying(36) NOT NULL,
    "toolCallId" character varying(64),
    "messageGroupId" character varying(36),
    "checkpointKey" character varying(255),
    "checkpointTaskId" character varying(36),
    "expiresAt" timestamp(3) with time zone,
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    CONSTRAINT "CHK_instance_ai_pending_confirmations_kind" CHECK ((("kind")::"text" = ANY ((ARRAY['suspended'::character varying, 'inline'::character varying])::"text"[])))
);


ALTER TABLE "public"."instance_ai_pending_confirmations" OWNER TO "postgres";


COMMENT ON COLUMN "public"."instance_ai_pending_confirmations"."requestId" IS 'HITL confirmation request identifier.';



COMMENT ON COLUMN "public"."instance_ai_pending_confirmations"."threadId" IS 'Instance AI thread that owns the confirmation.';



COMMENT ON COLUMN "public"."instance_ai_pending_confirmations"."userId" IS 'User who is expected to confirm or cancel.';



COMMENT ON COLUMN "public"."instance_ai_pending_confirmations"."kind" IS '''suspended'' (resumable from checkpoint) or ''inline'' (orchestrator-held Promise).';



COMMENT ON COLUMN "public"."instance_ai_pending_confirmations"."runId" IS 'External run ID; reused on resume for SSE correlation.';



COMMENT ON COLUMN "public"."instance_ai_pending_confirmations"."toolCallId" IS 'Suspended tool call awaiting confirmation.';



COMMENT ON COLUMN "public"."instance_ai_pending_confirmations"."messageGroupId" IS 'SSE event correlation group.';



COMMENT ON COLUMN "public"."instance_ai_pending_confirmations"."checkpointKey" IS 'FK to instance_ai_checkpoints.key; also the SDK runId used to resume.';



COMMENT ON COLUMN "public"."instance_ai_pending_confirmations"."checkpointTaskId" IS 'Set when the suspended run was a planned-task checkpoint follow-up.';



COMMENT ON COLUMN "public"."instance_ai_pending_confirmations"."expiresAt" IS 'TTL for the leader-only sweep; null disables auto-expiry.';



CREATE TABLE IF NOT EXISTS "public"."instance_ai_resources" (
    "id" character varying(255) NOT NULL,
    "workingMemory" "text",
    "metadata" json,
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL
);


ALTER TABLE "public"."instance_ai_resources" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."instance_ai_run_snapshots" (
    "threadId" "uuid" NOT NULL,
    "runId" character varying(36) NOT NULL,
    "messageGroupId" character varying(36),
    "runIds" json,
    "tree" "text" NOT NULL,
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "langsmithRunId" character varying(36),
    "langsmithTraceId" character varying(36),
    "traceId" character varying(64),
    "spanId" character varying(64)
);


ALTER TABLE "public"."instance_ai_run_snapshots" OWNER TO "postgres";


COMMENT ON COLUMN "public"."instance_ai_run_snapshots"."langsmithRunId" IS 'LangSmith run ID (UUID v4, e.g. "f47ac10b-58cc-4372-a567-0e02b2c3d479").';



COMMENT ON COLUMN "public"."instance_ai_run_snapshots"."langsmithTraceId" IS 'LangSmith trace ID (UUID v4, e.g. "f47ac10b-58cc-4372-a567-0e02b2c3d479").';



COMMENT ON COLUMN "public"."instance_ai_run_snapshots"."traceId" IS 'OpenTelemetry trace ID for the root Instance AI run.';



COMMENT ON COLUMN "public"."instance_ai_run_snapshots"."spanId" IS 'OpenTelemetry span ID for the root Instance AI run.';



CREATE TABLE IF NOT EXISTS "public"."instance_ai_thread_grants" (
    "threadId" "uuid" NOT NULL,
    "userId" "uuid" NOT NULL,
    "grantKey" character varying(512) NOT NULL,
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL
);


ALTER TABLE "public"."instance_ai_thread_grants" OWNER TO "postgres";


COMMENT ON COLUMN "public"."instance_ai_thread_grants"."grantKey" IS 'Namespaced "always allow" grant the user approved for the thread, e.g. "executions:run:<workflowId>". Wide enough to hold a namespace prefix plus a resource identifier.';



CREATE TABLE IF NOT EXISTS "public"."instance_ai_threads" (
    "id" "uuid" NOT NULL,
    "resourceId" character varying(255) NOT NULL,
    "title" "text" DEFAULT ''::"text" NOT NULL,
    "metadata" json,
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "projectId" character varying(36) NOT NULL
);


ALTER TABLE "public"."instance_ai_threads" OWNER TO "postgres";


COMMENT ON COLUMN "public"."instance_ai_threads"."projectId" IS 'Project this thread is scoped to';



CREATE TABLE IF NOT EXISTS "public"."instance_ai_workflow_snapshots" (
    "runId" character varying(36) NOT NULL,
    "workflowName" character varying(255) NOT NULL,
    "resourceId" character varying(255),
    "status" character varying,
    "snapshot" "text" NOT NULL,
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL
);


ALTER TABLE "public"."instance_ai_workflow_snapshots" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."instance_version_history" (
    "id" integer NOT NULL,
    "major" integer NOT NULL,
    "minor" integer NOT NULL,
    "patch" integer NOT NULL,
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL
);


ALTER TABLE "public"."instance_version_history" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "public"."instance_version_history_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "public"."instance_version_history_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."instance_version_history_id_seq" OWNED BY "public"."instance_version_history"."id";



CREATE TABLE IF NOT EXISTS "public"."invalid_auth_token" (
    "token" character varying(512) NOT NULL,
    "expiresAt" timestamp(3) with time zone NOT NULL
);


ALTER TABLE "public"."invalid_auth_token" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."mcp_registry_server" (
    "slug" character varying(255) NOT NULL,
    "status" character varying(50) NOT NULL,
    "version" character varying(50) NOT NULL,
    "registryUpdatedAt" timestamp(3) without time zone NOT NULL,
    "data" json DEFAULT '{}'::json NOT NULL,
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    CONSTRAINT "CHK_tmp_mcp_registry_server_status" CHECK ((("status")::"text" = ANY ((ARRAY['active'::character varying, 'deprecated'::character varying])::"text"[])))
);


ALTER TABLE "public"."mcp_registry_server" OWNER TO "postgres";


COMMENT ON COLUMN "public"."mcp_registry_server"."status" IS 'Server status in the MCP registry. Deprecated servers are not surfaced to users.';



COMMENT ON COLUMN "public"."mcp_registry_server"."data" IS 'JSON object containing server metadata (icons, remotes, tools, etc.)';



CREATE TABLE IF NOT EXISTS "public"."migrations" (
    "id" integer NOT NULL,
    "timestamp" bigint NOT NULL,
    "name" character varying NOT NULL
);


ALTER TABLE "public"."migrations" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "public"."migrations_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "public"."migrations_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."migrations_id_seq" OWNED BY "public"."migrations"."id";



CREATE TABLE IF NOT EXISTS "public"."oauth_access_tokens" (
    "token" character varying NOT NULL,
    "clientId" character varying NOT NULL,
    "userId" "uuid" NOT NULL
);


ALTER TABLE "public"."oauth_access_tokens" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."oauth_authorization_codes" (
    "code" character varying(255) NOT NULL,
    "clientId" character varying NOT NULL,
    "userId" "uuid" NOT NULL,
    "redirectUri" character varying NOT NULL,
    "codeChallenge" character varying NOT NULL,
    "codeChallengeMethod" character varying(255) NOT NULL,
    "expiresAt" bigint NOT NULL,
    "state" character varying,
    "used" boolean DEFAULT false NOT NULL,
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "resource" character varying,
    "scope" json DEFAULT '["tool:listWorkflows","tool:getWorkflowDetails"]'::json NOT NULL
);


ALTER TABLE "public"."oauth_authorization_codes" OWNER TO "postgres";


COMMENT ON COLUMN "public"."oauth_authorization_codes"."expiresAt" IS 'Unix timestamp in milliseconds';



COMMENT ON COLUMN "public"."oauth_authorization_codes"."resource" IS 'RFC 8707 resource indicator URI (e.g. https://n8n.example.com/mcp-server/http). NULL = legacy flow predating resource indicator support; defaults to the instance canonical MCP resource URL.';



COMMENT ON COLUMN "public"."oauth_authorization_codes"."scope" IS 'OAuth scopes granted for this authorization code';



CREATE TABLE IF NOT EXISTS "public"."oauth_clients" (
    "id" character varying NOT NULL,
    "name" character varying(255) NOT NULL,
    "redirectUris" json NOT NULL,
    "grantTypes" json NOT NULL,
    "clientSecret" character varying(255),
    "clientSecretExpiresAt" bigint,
    "tokenEndpointAuthMethod" character varying(255) DEFAULT 'none'::character varying NOT NULL,
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL
);


ALTER TABLE "public"."oauth_clients" OWNER TO "postgres";


COMMENT ON COLUMN "public"."oauth_clients"."tokenEndpointAuthMethod" IS 'Possible values: none, client_secret_basic or client_secret_post';



CREATE TABLE IF NOT EXISTS "public"."oauth_refresh_tokens" (
    "token" character varying(255) NOT NULL,
    "clientId" character varying NOT NULL,
    "userId" "uuid" NOT NULL,
    "expiresAt" bigint NOT NULL,
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "scope" json DEFAULT '["tool:listWorkflows","tool:getWorkflowDetails"]'::json NOT NULL
);


ALTER TABLE "public"."oauth_refresh_tokens" OWNER TO "postgres";


COMMENT ON COLUMN "public"."oauth_refresh_tokens"."expiresAt" IS 'Unix timestamp in milliseconds';



COMMENT ON COLUMN "public"."oauth_refresh_tokens"."scope" IS 'OAuth scopes granted for this refresh token';



CREATE TABLE IF NOT EXISTS "public"."oauth_user_consents" (
    "id" integer NOT NULL,
    "userId" "uuid" NOT NULL,
    "clientId" character varying NOT NULL,
    "grantedAt" bigint NOT NULL
);


ALTER TABLE "public"."oauth_user_consents" OWNER TO "postgres";


COMMENT ON COLUMN "public"."oauth_user_consents"."grantedAt" IS 'Unix timestamp in milliseconds';



ALTER TABLE "public"."oauth_user_consents" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."oauth_user_consents_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."processed_data" (
    "workflowId" character varying(36) NOT NULL,
    "context" character varying(255) NOT NULL,
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "value" "text" NOT NULL
);


ALTER TABLE "public"."processed_data" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."project" (
    "id" character varying(36) NOT NULL,
    "name" character varying(255) NOT NULL,
    "type" character varying(36) NOT NULL,
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "icon" json,
    "description" character varying(512),
    "creatorId" "uuid",
    "customTelemetryTags" json DEFAULT '[]'::json NOT NULL
);


ALTER TABLE "public"."project" OWNER TO "postgres";


COMMENT ON COLUMN "public"."project"."creatorId" IS 'ID of the user who created the project';



CREATE TABLE IF NOT EXISTS "public"."project_relation" (
    "projectId" character varying(36) NOT NULL,
    "userId" "uuid" NOT NULL,
    "role" character varying NOT NULL,
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL
);


ALTER TABLE "public"."project_relation" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."project_secrets_provider_access" (
    "secretsProviderConnectionId" integer NOT NULL,
    "projectId" character varying(36) NOT NULL,
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "role" character varying(128) DEFAULT 'secretsProviderConnection:user'::character varying NOT NULL,
    CONSTRAINT "CHK_project_secrets_provider_access_role" CHECK ((("role")::"text" = ANY ((ARRAY['secretsProviderConnection:owner'::character varying, 'secretsProviderConnection:user'::character varying])::"text"[])))
);


ALTER TABLE "public"."project_secrets_provider_access" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."role" (
    "slug" character varying(128) NOT NULL,
    "displayName" "text",
    "description" "text",
    "roleType" "text",
    "systemRole" boolean DEFAULT false NOT NULL,
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL
);


ALTER TABLE "public"."role" OWNER TO "postgres";


COMMENT ON COLUMN "public"."role"."slug" IS 'Unique identifier of the role for example: "global:owner"';



COMMENT ON COLUMN "public"."role"."displayName" IS 'Name used to display in the UI';



COMMENT ON COLUMN "public"."role"."description" IS 'Text describing the scope in more detail of users';



COMMENT ON COLUMN "public"."role"."roleType" IS 'Type of the role, e.g., global, project, or workflow';



COMMENT ON COLUMN "public"."role"."systemRole" IS 'Indicates if the role is managed by the system and cannot be edited';



CREATE TABLE IF NOT EXISTS "public"."role_mapping_rule" (
    "id" character varying(16) NOT NULL,
    "expression" "text" NOT NULL,
    "role" character varying(128) NOT NULL,
    "type" character varying(64) NOT NULL,
    "order" integer NOT NULL,
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL
);


ALTER TABLE "public"."role_mapping_rule" OWNER TO "postgres";


COMMENT ON COLUMN "public"."role_mapping_rule"."type" IS 'Expected values: ''instance'' (maps to a global role) or ''project'' (maps to a project role; projects linked via role_mapping_rule_project).';



CREATE TABLE IF NOT EXISTS "public"."role_mapping_rule_project" (
    "roleMappingRuleId" character varying(16) NOT NULL,
    "projectId" character varying(36) NOT NULL
);


ALTER TABLE "public"."role_mapping_rule_project" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."role_scope" (
    "roleSlug" character varying(128) NOT NULL,
    "scopeSlug" character varying(128) NOT NULL
);


ALTER TABLE "public"."role_scope" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."scheduled_job" (
    "id" integer NOT NULL,
    "name" character varying(255) NOT NULL,
    "workflowId" character varying(36),
    "nodeId" character varying(36),
    "taskType" character varying(128) NOT NULL,
    "payload" json DEFAULT '{}'::json NOT NULL,
    "kind" character varying(16) NOT NULL,
    "cronExpression" character varying(255),
    "timezone" character varying(64),
    "intervalSeconds" integer,
    "fireAt" timestamp(3) with time zone,
    "enabled" boolean DEFAULT true NOT NULL,
    "nextRunAt" timestamp(3) with time zone,
    "lastFiredAt" timestamp(3) with time zone,
    "maxAttempts" integer DEFAULT 1 NOT NULL,
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "recurrenceUnit" character varying(16),
    "recurrenceSize" integer,
    CONSTRAINT "CHK_scheduled_job_cron_expression" CHECK (((("kind")::"text" <> 'cron'::"text") OR ("cronExpression" IS NOT NULL))),
    CONSTRAINT "CHK_scheduled_job_fire_at" CHECK (((("kind")::"text" <> 'one_off'::"text") OR ("fireAt" IS NOT NULL))),
    CONSTRAINT "CHK_scheduled_job_interval_seconds" CHECK (((("kind")::"text" <> 'interval'::"text") OR ("intervalSeconds" IS NOT NULL))),
    CONSTRAINT "CHK_scheduled_job_kind" CHECK ((("kind")::"text" = ANY ((ARRAY['cron'::character varying, 'interval'::character varying, 'one_off'::character varying, 'recurring_cron'::character varying])::"text"[]))),
    CONSTRAINT "CHK_scheduled_job_recurrence_size" CHECK (("recurrenceSize" >= 2)),
    CONSTRAINT "CHK_scheduled_job_recurrence_unit" CHECK ((("recurrenceUnit")::"text" = ANY ((ARRAY['hours'::character varying, 'days'::character varying, 'weeks'::character varying, 'months'::character varying])::"text"[]))),
    CONSTRAINT "CHK_scheduled_job_recurring_cron" CHECK (((("kind")::"text" <> 'recurring_cron'::"text") OR (("cronExpression" IS NOT NULL) AND ("recurrenceUnit" IS NOT NULL) AND ("recurrenceSize" IS NOT NULL))))
);


ALTER TABLE "public"."scheduled_job" OWNER TO "postgres";


COMMENT ON COLUMN "public"."scheduled_job"."name" IS 'Human-readable job name. A well-known scheduler key for system jobs; generated for workflow trigger jobs.';



COMMENT ON COLUMN "public"."scheduled_job"."workflowId" IS 'References the workflow''s published version, since only published trigger nodes get scheduled; NULL for system jobs not tied to a workflow. Unpublishing the workflow deletes its jobs.';



COMMENT ON COLUMN "public"."scheduled_job"."nodeId" IS 'Trigger node within the workflow that owns this job; NULL for non-trigger jobs.';



COMMENT ON COLUMN "public"."scheduled_job"."taskType" IS 'Selects which registered handler runs the task.';



COMMENT ON COLUMN "public"."scheduled_job"."payload" IS 'Input passed to the task handler when an occurrence runs.';



COMMENT ON COLUMN "public"."scheduled_job"."kind" IS 'Recurrence kind; selects which of the schedule columns below apply.';



COMMENT ON COLUMN "public"."scheduled_job"."cronExpression" IS 'Cron expression. For kind ''cron'' it is the schedule; for ''recurring_cron'' it lists the candidate run times that the every-N-periods filter then keeps every Nth of.';



COMMENT ON COLUMN "public"."scheduled_job"."timezone" IS 'IANA timezone the cron expression is evaluated in; NULL uses the instance default.';



COMMENT ON COLUMN "public"."scheduled_job"."intervalSeconds" IS 'Gap between fires in seconds; set only when kind is ''interval''.';



COMMENT ON COLUMN "public"."scheduled_job"."fireAt" IS 'Absolute time the job fires once; set only when kind is ''one_off''.';



COMMENT ON COLUMN "public"."scheduled_job"."enabled" IS 'Whether the scheduler considers this job for firing.';



COMMENT ON COLUMN "public"."scheduled_job"."nextRunAt" IS 'Next time an occurrence is due; the scheduler sweep reads this to find work. NULL once disabled or a one-off has fired.';



COMMENT ON COLUMN "public"."scheduled_job"."lastFiredAt" IS 'Last time an occurrence was materialized; used to recompute nextRunAt.';



COMMENT ON COLUMN "public"."scheduled_job"."maxAttempts" IS 'Retry ceiling copied onto each occurrence this job materializes.';



COMMENT ON COLUMN "public"."scheduled_job"."recurrenceUnit" IS 'Calendar period counted by a recurring_cron schedule''s every-N-periods filter (hours, days, weeks, months). Set only when kind is ''recurring_cron''.';



COMMENT ON COLUMN "public"."scheduled_job"."recurrenceSize" IS 'The N in a recurring_cron schedule''s every-N-periods filter, e.g. 3 for every 3 weeks; at least 2. Set only when kind is ''recurring_cron''.';



ALTER TABLE "public"."scheduled_job" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."scheduled_job_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."scheduled_task" (
    "id" bigint NOT NULL,
    "jobId" integer NOT NULL,
    "taskType" character varying(128) NOT NULL,
    "payload" json DEFAULT '{}'::json NOT NULL,
    "scheduledFor" timestamp(3) with time zone NOT NULL,
    "runAt" timestamp(3) with time zone NOT NULL,
    "status" character varying(16) DEFAULT 'pending'::character varying NOT NULL,
    "attempts" integer DEFAULT 0 NOT NULL,
    "maxAttempts" integer DEFAULT 1 NOT NULL,
    "claimedBy" character varying(255),
    "leaseExpiresAt" timestamp(3) with time zone,
    "leaseEpoch" integer DEFAULT 0 NOT NULL,
    "startedAt" timestamp(3) with time zone,
    "finishedAt" timestamp(3) with time zone,
    "errorMessage" "text",
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    CONSTRAINT "CHK_scheduled_task_running_lease" CHECK (((("status")::"text" <> 'running'::"text") OR ("leaseExpiresAt" IS NOT NULL))),
    CONSTRAINT "CHK_scheduled_task_status" CHECK ((("status")::"text" = ANY ((ARRAY['pending'::character varying, 'running'::character varying, 'succeeded'::character varying, 'failed'::character varying, 'missed'::character varying, 'cancelled'::character varying])::"text"[])))
);


ALTER TABLE "public"."scheduled_task" OWNER TO "postgres";


COMMENT ON COLUMN "public"."scheduled_task"."jobId" IS 'The scheduled_job this occurrence belongs to.';



COMMENT ON COLUMN "public"."scheduled_task"."taskType" IS 'What kind of work to run, copied from the job so a run is self-contained (no join to execute it). Also lets a run exist without a parent job in future.';



COMMENT ON COLUMN "public"."scheduled_task"."payload" IS 'Handler input copied from the job. A snapshot, so editing the job later doesn''t change runs already queued.';



COMMENT ON COLUMN "public"."scheduled_task"."scheduledFor" IS 'The logical fire time this occurrence represents; unique per job, so the same instant cannot be queued twice.';



COMMENT ON COLUMN "public"."scheduled_task"."runAt" IS 'Earliest time the executor may pick this up; starts at scheduledFor and is pushed out by retry backoff.';



COMMENT ON COLUMN "public"."scheduled_task"."status" IS 'Lifecycle state; drives which occurrences the claim and reaper scans consider.';



COMMENT ON COLUMN "public"."scheduled_task"."attempts" IS 'Execution attempts started so far; compared against maxAttempts.';



COMMENT ON COLUMN "public"."scheduled_task"."maxAttempts" IS 'Attempt ceiling; once attempts reaches it, a failure is final rather than retried.';



COMMENT ON COLUMN "public"."scheduled_task"."claimedBy" IS 'Id of the instance currently holding the lease; NULL when unclaimed.';



COMMENT ON COLUMN "public"."scheduled_task"."leaseExpiresAt" IS 'When the current lease expires; the reaper reclaims running occurrences past this.';



COMMENT ON COLUMN "public"."scheduled_task"."leaseEpoch" IS 'Fencing token bumped on each claim; lets a reaped worker detect it lost ownership and not overwrite the new owner''s results.';



COMMENT ON COLUMN "public"."scheduled_task"."startedAt" IS 'When the current attempt started running.';



COMMENT ON COLUMN "public"."scheduled_task"."finishedAt" IS 'When the occurrence reached a terminal state; drives retention pruning.';



COMMENT ON COLUMN "public"."scheduled_task"."errorMessage" IS 'Failure detail from the last attempt.';



ALTER TABLE "public"."scheduled_task" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."scheduled_task_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."scope" (
    "slug" character varying(128) NOT NULL,
    "displayName" "text",
    "description" "text"
);


ALTER TABLE "public"."scope" OWNER TO "postgres";


COMMENT ON COLUMN "public"."scope"."slug" IS 'Unique identifier of the scope for example: "project:create"';



COMMENT ON COLUMN "public"."scope"."displayName" IS 'Name used to display in the UI';



COMMENT ON COLUMN "public"."scope"."description" IS 'Text describing the scope in more detail of users';



CREATE TABLE IF NOT EXISTS "public"."secrets_provider_connection" (
    "id" integer NOT NULL,
    "providerKey" character varying(128) NOT NULL,
    "type" character varying(36) NOT NULL,
    "encryptedSettings" "text" NOT NULL,
    "isEnabled" boolean DEFAULT false NOT NULL,
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL
);


ALTER TABLE "public"."secrets_provider_connection" OWNER TO "postgres";


COMMENT ON COLUMN "public"."secrets_provider_connection"."type" IS 'Type of secrets provider. Possible values: awsSecretsManager, gcpSecretsManager, vault, azureKeyVault, infisical';



ALTER TABLE "public"."secrets_provider_connection" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."secrets_provider_connection_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."settings" (
    "key" character varying(255) NOT NULL,
    "value" "text" NOT NULL,
    "loadOnStartup" boolean DEFAULT false NOT NULL
);


ALTER TABLE "public"."settings" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."shared_credentials" (
    "credentialsId" character varying(36) NOT NULL,
    "projectId" character varying(36) NOT NULL,
    "role" "text" NOT NULL,
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL
);


ALTER TABLE "public"."shared_credentials" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."shared_workflow" (
    "workflowId" character varying(36) NOT NULL,
    "projectId" character varying(36) NOT NULL,
    "role" "text" NOT NULL,
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL
);


ALTER TABLE "public"."shared_workflow" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."tag_entity" (
    "name" character varying(24) NOT NULL,
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "id" character varying(36) NOT NULL
);


ALTER TABLE "public"."tag_entity" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."test_case_execution" (
    "id" character varying(36) NOT NULL,
    "testRunId" character varying(36) NOT NULL,
    "executionId" integer,
    "status" character varying NOT NULL,
    "runAt" timestamp(3) with time zone,
    "completedAt" timestamp(3) with time zone,
    "errorCode" character varying,
    "errorDetails" json,
    "metrics" json,
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "inputs" json,
    "outputs" json,
    "runIndex" integer
);


ALTER TABLE "public"."test_case_execution" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."test_run" (
    "id" character varying(36) NOT NULL,
    "workflowId" character varying(36) NOT NULL,
    "status" character varying NOT NULL,
    "errorCode" character varying,
    "errorDetails" json,
    "runAt" timestamp(3) with time zone,
    "completedAt" timestamp(3) with time zone,
    "metrics" json,
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "runningInstanceId" character varying(255),
    "cancelRequested" boolean DEFAULT false NOT NULL,
    "workflowVersionId" character varying(36),
    "evaluationConfigId" character varying(36),
    "evaluationConfigSnapshot" "jsonb",
    "collectionId" character varying(36)
);


ALTER TABLE "public"."test_run" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."token_exchange_jti" (
    "jti" character varying(255) NOT NULL,
    "expiresAt" timestamp(3) with time zone NOT NULL,
    "createdAt" timestamp(3) with time zone NOT NULL
);


ALTER TABLE "public"."token_exchange_jti" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."trusted_key" (
    "sourceId" character varying(36) NOT NULL,
    "kid" character varying(255) NOT NULL,
    "data" "text" NOT NULL,
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL
);


ALTER TABLE "public"."trusted_key" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."trusted_key_source" (
    "id" character varying(36) NOT NULL,
    "type" character varying(32) NOT NULL,
    "config" "text" NOT NULL,
    "status" character varying(32) DEFAULT 'pending'::character varying NOT NULL,
    "lastError" "text",
    "lastRefreshedAt" timestamp(3) with time zone,
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL
);


ALTER TABLE "public"."trusted_key_source" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."user" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "email" character varying(255),
    "firstName" character varying(32),
    "lastName" character varying(32),
    "password" character varying(255),
    "personalizationAnswers" json,
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "settings" json,
    "disabled" boolean DEFAULT false NOT NULL,
    "mfaEnabled" boolean DEFAULT false NOT NULL,
    "mfaSecret" "text",
    "mfaRecoveryCodes" "text",
    "lastActiveAt" "date",
    "roleSlug" character varying(128) DEFAULT 'global:member'::character varying NOT NULL
);


ALTER TABLE "public"."user" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."user_api_keys" (
    "id" character varying(36) NOT NULL,
    "userId" "uuid" NOT NULL,
    "label" character varying(100) NOT NULL,
    "apiKey" character varying NOT NULL,
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "scopes" json,
    "audience" character varying DEFAULT 'public-api'::character varying NOT NULL,
    "lastUsedAt" timestamp(3) with time zone
);


ALTER TABLE "public"."user_api_keys" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."user_favorites" (
    "id" integer NOT NULL,
    "userId" "uuid" NOT NULL,
    "resourceId" character varying(255) NOT NULL,
    "resourceType" character varying(64) NOT NULL
);


ALTER TABLE "public"."user_favorites" OWNER TO "postgres";


ALTER TABLE "public"."user_favorites" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."user_favorites_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."variables" (
    "key" character varying(50) NOT NULL,
    "type" character varying(50) DEFAULT 'string'::character varying NOT NULL,
    "value" "text",
    "id" character varying(36) NOT NULL,
    "projectId" character varying(36),
    CONSTRAINT "variables_value_max_len" CHECK ((("value" IS NULL) OR ("char_length"("value") <= 1000)))
);


ALTER TABLE "public"."variables" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."webhook_entity" (
    "webhookPath" character varying NOT NULL,
    "method" character varying NOT NULL,
    "node" character varying NOT NULL,
    "webhookId" character varying,
    "pathLength" integer,
    "workflowId" character varying(36) NOT NULL
);


ALTER TABLE "public"."webhook_entity" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."workflow_builder_session" (
    "id" "uuid" NOT NULL,
    "workflowId" character varying(36) NOT NULL,
    "userId" "uuid" NOT NULL,
    "messages" json DEFAULT '[]'::json NOT NULL,
    "previousSummary" "text",
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "activeVersionCardId" character varying(255),
    "resumeAfterRestoreMessageId" character varying(255)
);


ALTER TABLE "public"."workflow_builder_session" OWNER TO "postgres";


COMMENT ON COLUMN "public"."workflow_builder_session"."previousSummary" IS 'Summary of prior conversation from compaction (/compact or auto-compact)';



CREATE TABLE IF NOT EXISTS "public"."workflow_dependency" (
    "id" integer NOT NULL,
    "workflowId" character varying(36) NOT NULL,
    "workflowVersionId" integer NOT NULL,
    "dependencyType" character varying(32) NOT NULL,
    "dependencyKey" character varying(255) NOT NULL,
    "dependencyInfo" json,
    "indexVersionId" smallint DEFAULT 1 NOT NULL,
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "publishedVersionId" character varying(36)
);


ALTER TABLE "public"."workflow_dependency" OWNER TO "postgres";


COMMENT ON COLUMN "public"."workflow_dependency"."workflowVersionId" IS 'Version of the workflow';



COMMENT ON COLUMN "public"."workflow_dependency"."dependencyType" IS 'Type of dependency: "credential", "nodeType", "webhookPath", or "workflowCall"';



COMMENT ON COLUMN "public"."workflow_dependency"."dependencyKey" IS 'ID or name of the dependency';



COMMENT ON COLUMN "public"."workflow_dependency"."dependencyInfo" IS 'Additional info about the dependency, interpreted based on type';



COMMENT ON COLUMN "public"."workflow_dependency"."indexVersionId" IS 'Version of the index structure';



ALTER TABLE "public"."workflow_dependency" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."workflow_dependency_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."workflow_entity" (
    "name" character varying(128) NOT NULL,
    "active" boolean NOT NULL,
    "nodes" json NOT NULL,
    "connections" json NOT NULL,
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "settings" json,
    "staticData" json,
    "pinData" json,
    "versionId" character(36) NOT NULL,
    "triggerCount" integer DEFAULT 0 NOT NULL,
    "id" character varying(36) NOT NULL,
    "meta" json,
    "parentFolderId" character varying(36) DEFAULT NULL::character varying,
    "isArchived" boolean DEFAULT false NOT NULL,
    "versionCounter" integer DEFAULT 1 NOT NULL,
    "description" "text",
    "activeVersionId" character varying(36),
    "nodeGroups" json DEFAULT '[]'::json NOT NULL,
    "sourceWorkflowId" character varying
);


ALTER TABLE "public"."workflow_entity" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."workflow_history" (
    "versionId" character varying(36) NOT NULL,
    "workflowId" character varying(36) NOT NULL,
    "authors" character varying(255) NOT NULL,
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "nodes" json NOT NULL,
    "connections" json NOT NULL,
    "name" character varying(128),
    "autosaved" boolean DEFAULT false NOT NULL,
    "description" "text",
    "nodeGroups" json DEFAULT '[]'::json NOT NULL
);


ALTER TABLE "public"."workflow_history" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."workflow_publication_outbox" (
    "id" integer NOT NULL,
    "workflowId" character varying(36) NOT NULL,
    "publishedVersionId" character varying(36) NOT NULL,
    "status" character varying(20) NOT NULL,
    "errorMessage" "text",
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    CONSTRAINT "CHK_workflow_publication_outbox_status" CHECK ((("status")::"text" = ANY ((ARRAY['pending'::character varying, 'in_progress'::character varying, 'completed'::character varying, 'partial_success'::character varying, 'failed'::character varying])::"text"[])))
);


ALTER TABLE "public"."workflow_publication_outbox" OWNER TO "postgres";


COMMENT ON COLUMN "public"."workflow_publication_outbox"."workflowId" IS 'References workflow_entity.id.';



COMMENT ON COLUMN "public"."workflow_publication_outbox"."publishedVersionId" IS 'References workflow_history.versionId.';



COMMENT ON COLUMN "public"."workflow_publication_outbox"."errorMessage" IS 'Error details for surfacing failed publications to the user.';



ALTER TABLE "public"."workflow_publication_outbox" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."workflow_publication_outbox_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."workflow_publication_trigger_status" (
    "workflowId" character varying(36) NOT NULL,
    "nodeId" character varying(36) NOT NULL,
    "versionId" character varying(36) NOT NULL,
    "status" character varying(20) NOT NULL,
    "errorMessage" "text",
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "triggerKind" character varying(20) NOT NULL,
    CONSTRAINT "CHK_workflow_publication_trigger_status_status" CHECK ((("status")::"text" = ANY ((ARRAY['activated'::character varying, 'failed'::character varying])::"text"[]))),
    CONSTRAINT "CHK_workflow_publication_trigger_status_triggerKind" CHECK ((("triggerKind")::"text" = ANY ((ARRAY['in-memory'::character varying, 'persisted'::character varying])::"text"[])))
);


ALTER TABLE "public"."workflow_publication_trigger_status" OWNER TO "postgres";


COMMENT ON COLUMN "public"."workflow_publication_trigger_status"."versionId" IS 'References workflow_history.versionId: the published version these statuses were recorded for';



COMMENT ON COLUMN "public"."workflow_publication_trigger_status"."triggerKind" IS 'Where the trigger lives once activated: in-memory (registered on the owning instance) vs persisted (webhook row in webhook_entity)';



CREATE TABLE IF NOT EXISTS "public"."workflow_publish_history" (
    "id" integer NOT NULL,
    "workflowId" character varying(36) NOT NULL,
    "versionId" character varying(36),
    "event" character varying(36) NOT NULL,
    "userId" "uuid",
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    CONSTRAINT "CHK_workflow_publish_history_event" CHECK ((("event")::"text" = ANY ((ARRAY['activated'::character varying, 'deactivated'::character varying])::"text"[])))
);


ALTER TABLE "public"."workflow_publish_history" OWNER TO "postgres";


COMMENT ON COLUMN "public"."workflow_publish_history"."event" IS 'Type of history record: activated (workflow is now active), deactivated (workflow is now inactive)';



ALTER TABLE "public"."workflow_publish_history" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."workflow_publish_history_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."workflow_published_version" (
    "workflowId" character varying(36) NOT NULL,
    "publishedVersionId" character varying(36) NOT NULL,
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL
);


ALTER TABLE "public"."workflow_published_version" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."workflow_statistics" (
    "count" bigint DEFAULT 0,
    "latestEvent" timestamp(3) with time zone,
    "name" character varying(128) NOT NULL,
    "workflowId" character varying(36) NOT NULL,
    "rootCount" bigint DEFAULT 0,
    "id" integer NOT NULL,
    "workflowName" character varying(128)
);


ALTER TABLE "public"."workflow_statistics" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."workflow_statistics_delta" (
    "id" bigint NOT NULL,
    "workflowId" character varying(36) NOT NULL,
    "name" character varying(128) NOT NULL,
    "rootCountDelta" smallint NOT NULL,
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "workflowName" character varying(128)
)
WITH ("autovacuum_vacuum_scale_factor"='0.0', "autovacuum_vacuum_threshold"='1000', "autovacuum_vacuum_cost_delay"='0');


ALTER TABLE "public"."workflow_statistics_delta" OWNER TO "postgres";


ALTER TABLE "public"."workflow_statistics_delta" ALTER COLUMN "id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "public"."workflow_statistics_delta_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE SEQUENCE IF NOT EXISTS "public"."workflow_statistics_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "public"."workflow_statistics_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."workflow_statistics_id_seq" OWNED BY "public"."workflow_statistics"."id";



CREATE TABLE IF NOT EXISTS "public"."workflows_tags" (
    "workflowId" character varying(36) NOT NULL,
    "tagId" character varying(36) NOT NULL
);


ALTER TABLE "public"."workflows_tags" OWNER TO "postgres";


ALTER TABLE ONLY "public"."auth_provider_sync_history" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."auth_provider_sync_history_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."execution_annotations" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."execution_annotations_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."execution_entity" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."execution_entity_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."execution_metadata" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."execution_metadata_temp_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."instance_version_history" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."instance_version_history_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."migrations" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."migrations_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."workflow_statistics" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."workflow_statistics_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."test_run"
    ADD CONSTRAINT "PK_011c050f566e9db509a0fadb9b9" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."project_secrets_provider_access"
    ADD CONSTRAINT "PK_0402b7fcec5415246656f102f83" PRIMARY KEY ("secretsProviderConnectionId", "projectId");



ALTER TABLE ONLY "public"."installed_packages"
    ADD CONSTRAINT "PK_08cc9197c39b028c1e9beca225940576fd1a5804" PRIMARY KEY ("packageName");



ALTER TABLE ONLY "public"."instance_ai_run_snapshots"
    ADD CONSTRAINT "PK_0a5fc9690a84950ebf1416fb146" PRIMARY KEY ("threadId", "runId");



ALTER TABLE ONLY "public"."mcp_registry_server"
    ADD CONSTRAINT "PK_12fd89a1fb8489513b0a91f5d31" PRIMARY KEY ("slug");



ALTER TABLE ONLY "public"."workflow_publication_trigger_status"
    ADD CONSTRAINT "PK_14aa18b83513fb92d7523909e02" PRIMARY KEY ("workflowId", "nodeId");



ALTER TABLE ONLY "public"."instance_ai_messages"
    ADD CONSTRAINT "PK_156c6f287225e9befe0181bb02b" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."agent_task_definition"
    ADD CONSTRAINT "PK_1756c11c637903e97629a7a784a" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."execution_metadata"
    ADD CONSTRAINT "PK_17a0b6284f8d626aae88e1c16e4" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."role_mapping_rule_project"
    ADD CONSTRAINT "PK_198c5b5aea509d139274efcaf9a" PRIMARY KEY ("roleMappingRuleId", "projectId");



ALTER TABLE ONLY "public"."project_relation"
    ADD CONSTRAINT "PK_1caaa312a5d7184a003be0f0cb6" PRIMARY KEY ("projectId", "userId");



ALTER TABLE ONLY "public"."chat_hub_sessions"
    ADD CONSTRAINT "PK_1eafef1273c70e4464fec703412" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."agent_task_snapshot"
    ADD CONSTRAINT "PK_2142a8bcda2360c3c5e34f82640" PRIMARY KEY ("versionId", "taskId");



ALTER TABLE ONLY "public"."instance_ai_iteration_logs"
    ADD CONSTRAINT "PK_21c2b214b44bc6c34a6d3551c90" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."agent_execution_threads"
    ADD CONSTRAINT "PK_22373dbf6ba6929d8ac50093309" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."instance_ai_pending_confirmations"
    ADD CONSTRAINT "PK_25c38179c8d45095b168adfff80" PRIMARY KEY ("requestId");



ALTER TABLE ONLY "public"."agents_memory_entry_sources"
    ADD CONSTRAINT "PK_278f05e98e74baaaa93f52b4bab" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."folder_tag"
    ADD CONSTRAINT "PK_27e4e00852f6b06a925a4d83a3e" PRIMARY KEY ("folderId", "tagId");



ALTER TABLE ONLY "public"."instance_ai_threads"
    ADD CONSTRAINT "PK_35575100e45cdedeb89ae0643e9" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."role"
    ADD CONSTRAINT "PK_35c9b140caaf6da09cfabb0d675" PRIMARY KEY ("slug");



ALTER TABLE ONLY "public"."secrets_provider_connection"
    ADD CONSTRAINT "PK_4350ae85e76f9ba7df1370acb5d" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."instance_ai_resources"
    ADD CONSTRAINT "PK_45b5b0b6f715dae4292b86603d8" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."agents_threads"
    ADD CONSTRAINT "PK_4a3feb0a13ffe315c009cce64e5" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."project"
    ADD CONSTRAINT "PK_4d68b1358bb5b766d3e78f32f57" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."instance_ai_observations"
    ADD CONSTRAINT "PK_4d9b514cdf0f0b577650caf2ac2" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."agent_checkpoints"
    ADD CONSTRAINT "PK_50a27cbafa6806c9b162304b5fd" PRIMARY KEY ("runId");



ALTER TABLE ONLY "public"."dynamic_credential_entry"
    ADD CONSTRAINT "PK_5135ffcabecad4727ff6b9b803d" PRIMARY KEY ("credential_id", "subject_id", "resolver_id");



ALTER TABLE ONLY "public"."workflow_dependency"
    ADD CONSTRAINT "PK_52325e34cd7a2f0f67b0f3cad65" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."instance_ai_checkpoints"
    ADD CONSTRAINT "PK_5315a45f0846d1f9d128c18a2ed" PRIMARY KEY ("key");



ALTER TABLE ONLY "public"."instance_ai_thread_grants"
    ADD CONSTRAINT "PK_56107d26ebeabf780c5cf311d66" PRIMARY KEY ("threadId", "userId", "grantKey");



ALTER TABLE ONLY "public"."invalid_auth_token"
    ADD CONSTRAINT "PK_5779069b7235b256d91f7af1a15" PRIMARY KEY ("token");



ALTER TABLE ONLY "public"."evaluation_config"
    ADD CONSTRAINT "PK_59c14dccf8989df94070c2dcfda" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."instance_ai_observation_cursors"
    ADD CONSTRAINT "PK_5b6319b2e9a37c1064a72428f9a" PRIMARY KEY ("observationScopeId");



ALTER TABLE ONLY "public"."shared_workflow"
    ADD CONSTRAINT "PK_5ba87620386b847201c9531c58f" PRIMARY KEY ("workflowId", "projectId");



ALTER TABLE ONLY "public"."workflow_published_version"
    ADD CONSTRAINT "PK_5c76fb7ee939fe2530374d3f75a" PRIMARY KEY ("workflowId");



ALTER TABLE ONLY "public"."folder"
    ADD CONSTRAINT "PK_6278a41a706740c94c02e288df8" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."agent_history"
    ADD CONSTRAINT "PK_65ffcfe7a8e112fb826311fb092" PRIMARY KEY ("versionId");



ALTER TABLE ONLY "public"."data_table_column"
    ADD CONSTRAINT "PK_673cb121ee4a8a5e27850c72c51" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."agent_files"
    ADD CONSTRAINT "PK_692920e59217af7d124cd95106f" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."chat_hub_tools"
    ADD CONSTRAINT "PK_696d26426c704fba79b2c195ef5" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."annotation_tag_entity"
    ADD CONSTRAINT "PK_69dfa041592c30bbc0d4b84aa00" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."user_favorites"
    ADD CONSTRAINT "PK_6c472a19a7423cfbbf6b7c75939" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."instance_ai_observational_memory"
    ADD CONSTRAINT "PK_7192dd00cddba039bf1d3e6a098" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."oauth_refresh_tokens"
    ADD CONSTRAINT "PK_74abaed0b30711b6532598b0392" PRIMARY KEY ("token");



ALTER TABLE ONLY "public"."dynamic_credential_user_entry"
    ADD CONSTRAINT "PK_74f548e633abc66dc27c8f0ca77" PRIMARY KEY ("credentialId", "userId", "resolverId");



ALTER TABLE ONLY "public"."agent_chat_subscriptions"
    ADD CONSTRAINT "PK_76598cf91038bee1f3ac94c94bc" PRIMARY KEY ("agentId", "integrationType", "credentialId", "threadId");



ALTER TABLE ONLY "public"."chat_hub_messages"
    ADD CONSTRAINT "PK_7704a5add6baed43eef835f0bfb" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."execution_annotations"
    ADD CONSTRAINT "PK_7afcf93ffa20c4252869a7c6a23" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."agents_observation_locks"
    ADD CONSTRAINT "PK_7e2e315162ac3d80587e15ac2c3" PRIMARY KEY ("agentId", "observationScopeId", "taskKind");



ALTER TABLE ONLY "public"."credential_dependency"
    ADD CONSTRAINT "PK_80212729ed0ffa0709417ab28f4" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."agents_messages"
    ADD CONSTRAINT "PK_81020dc608dfb0af1ede386d907" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."ai_builder_temporary_workflow"
    ADD CONSTRAINT "PK_85a87a1ba0f61999fe11dc56325" PRIMARY KEY ("workflowId");



ALTER TABLE ONLY "public"."oauth_user_consents"
    ADD CONSTRAINT "PK_85b9ada746802c8993103470f05" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."instance_version_history"
    ADD CONSTRAINT "PK_874f58cb616935bf49d9dbd67e9" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."chat_hub_session_tools"
    ADD CONSTRAINT "PK_87aea76ff4c274c4a5ac838ebe3" PRIMARY KEY ("sessionId", "toolId");



ALTER TABLE ONLY "public"."scheduled_job"
    ADD CONSTRAINT "PK_893185383f029ca8d57bb781fa8" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."migrations"
    ADD CONSTRAINT "PK_8c82d7f526340ab734260ea46be" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."installed_nodes"
    ADD CONSTRAINT "PK_8ebd28194e4f792f96b5933423fc439df97d9689" PRIMARY KEY ("name");



ALTER TABLE ONLY "public"."shared_credentials"
    ADD CONSTRAINT "PK_8ef3a59796a228913f251779cff" PRIMARY KEY ("credentialsId", "projectId");



ALTER TABLE ONLY "public"."test_case_execution"
    ADD CONSTRAINT "PK_90c121f77a78a6580e94b794bce" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."instance_ai_workflow_snapshots"
    ADD CONSTRAINT "PK_93f2696eb321dfe1d7defe7073f" PRIMARY KEY ("runId", "workflowName");



ALTER TABLE ONLY "public"."deployment_key"
    ADD CONSTRAINT "PK_94bb7aeb5def5a0284a5fe9f9a0" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."user_api_keys"
    ADD CONSTRAINT "PK_978fa5caa3468f463dac9d92e69" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."execution_annotation_tags"
    ADD CONSTRAINT "PK_979ec03d31294cca484be65d11f" PRIMARY KEY ("annotationId", "tagId");



ALTER TABLE ONLY "public"."trusted_key_source"
    ADD CONSTRAINT "PK_99e8908ce2c2cdccce487db7fc6" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."agents_observations"
    ADD CONSTRAINT "PK_9ad319654d12c2649f7caf27135" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."agents"
    ADD CONSTRAINT "PK_9c653f28ae19c5884d5baf6a1d9" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."agents_memory_entry_locks"
    ADD CONSTRAINT "PK_a8e0f570d04a174292bea104ae6" PRIMARY KEY ("agentId", "resourceId");



ALTER TABLE ONLY "public"."webhook_entity"
    ADD CONSTRAINT "PK_b21ace2e13596ccd87dc9bf4ea6" PRIMARY KEY ("webhookPath", "method");



ALTER TABLE ONLY "public"."agents_memory_entry_cursors"
    ADD CONSTRAINT "PK_b31a1d5c009a27f4cc5ef8f102a" PRIMARY KEY ("agentId", "observationScopeId");



ALTER TABLE ONLY "public"."workflow_publication_outbox"
    ADD CONSTRAINT "PK_b3e2eeee36a4bd044d56468d311" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."insights_by_period"
    ADD CONSTRAINT "PK_b606942249b90cc39b0265f0575" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."workflow_history"
    ADD CONSTRAINT "PK_b6572dd6173e4cd06fe79937b58" PRIMARY KEY ("versionId");



ALTER TABLE ONLY "public"."dynamic_credential_resolver"
    ADD CONSTRAINT "PK_b76cfb088dcdaf5275e9980bb64" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."agent_execution"
    ADD CONSTRAINT "PK_ba438acc8532addc12d1ef17049" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."agents_memory_entries"
    ADD CONSTRAINT "PK_bfbc45dc88f66fae4e4b4a15fec" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."scope"
    ADD CONSTRAINT "PK_bfc45df0481abd7f355d6187da1" PRIMARY KEY ("slug");



ALTER TABLE ONLY "public"."oauth_clients"
    ADD CONSTRAINT "PK_c4759172d3431bae6f04e678e0d" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."workflow_publish_history"
    ADD CONSTRAINT "PK_c788f7caf88e91e365c97d6d04a" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."processed_data"
    ADD CONSTRAINT "PK_ca04b9d8dc72de268fe07a65773" PRIMARY KEY ("workflowId", "context");



ALTER TABLE ONLY "public"."chat_hub_agent_tools"
    ADD CONSTRAINT "PK_cc8806fdea48297a7d497035d72" PRIMARY KEY ("agentId", "toolId");



ALTER TABLE ONLY "public"."scheduled_task"
    ADD CONSTRAINT "PK_d690af24e57e30594c1948af1e6" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."role_mapping_rule"
    ADD CONSTRAINT "PK_d772c8ec1a89b52d31c882bc560" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."token_exchange_jti"
    ADD CONSTRAINT "PK_d8e8a6f737d530fdd2dd716e89c" PRIMARY KEY ("jti");



ALTER TABLE ONLY "public"."settings"
    ADD CONSTRAINT "PK_dc0fe14e6d9943f268e7b119f69ab8bd" PRIMARY KEY ("key");



ALTER TABLE ONLY "public"."trusted_key"
    ADD CONSTRAINT "PK_dc7d93798f3dbb6959f974c97e1" PRIMARY KEY ("sourceId", "kid");



ALTER TABLE ONLY "public"."oauth_access_tokens"
    ADD CONSTRAINT "PK_dcd71f96a5d5f4bf79e67d322bf" PRIMARY KEY ("token");



ALTER TABLE ONLY "public"."data_table"
    ADD CONSTRAINT "PK_e226d0001b9e6097cbfe70617cb" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."instance_ai_mcp_registry_connections"
    ADD CONSTRAINT "PK_e34e4d15d78eabbe8217e33ef03" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."workflow_builder_session"
    ADD CONSTRAINT "PK_e69ef0d385986e273423b0e8695" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."evaluation_collection"
    ADD CONSTRAINT "PK_e720b6efc1e45b878ebb0b2ca30" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."user"
    ADD CONSTRAINT "PK_ea8f538c94b6e352418254ed6474a81f" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."agents_observation_cursors"
    ADD CONSTRAINT "PK_eb777ac57ab872d38f8ebd19317" PRIMARY KEY ("agentId", "observationScopeId");



ALTER TABLE ONLY "public"."insights_raw"
    ADD CONSTRAINT "PK_ec15125755151e3a7e00e00014f" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."chat_hub_agents"
    ADD CONSTRAINT "PK_f39a3b36bbdf0e2979ddb21cf78" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."insights_metadata"
    ADD CONSTRAINT "PK_f448a94c35218b6208ce20cf5a1" PRIMARY KEY ("metaId");



ALTER TABLE ONLY "public"."agent_task_run_lock"
    ADD CONSTRAINT "PK_f593adaf7230e964d3c25deda64" PRIMARY KEY ("agentId", "taskId");



ALTER TABLE ONLY "public"."agents_resources"
    ADD CONSTRAINT "PK_fa6b20b2d31a9991529dbf8ef7d" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."oauth_authorization_codes"
    ADD CONSTRAINT "PK_fb91ab932cfbd694061501cc20f" PRIMARY KEY ("code");



ALTER TABLE ONLY "public"."binary_data"
    ADD CONSTRAINT "PK_fc3691585b39408bb0551122af6" PRIMARY KEY ("fileId");



ALTER TABLE ONLY "public"."instance_ai_observation_locks"
    ADD CONSTRAINT "PK_fc491dd378b9448655c3c683f85" PRIMARY KEY ("observationScopeId", "taskKind");



ALTER TABLE ONLY "public"."role_scope"
    ADD CONSTRAINT "PK_role_scope" PRIMARY KEY ("roleSlug", "scopeSlug");



ALTER TABLE ONLY "public"."oauth_user_consents"
    ADD CONSTRAINT "UQ_083721d99ce8db4033e2958ebb4" UNIQUE ("userId", "clientId");



ALTER TABLE ONLY "public"."evaluation_config"
    ADD CONSTRAINT "UQ_3c3c99a712e971835c52292e44c" UNIQUE ("workflowId", "name");



ALTER TABLE ONLY "public"."data_table_column"
    ADD CONSTRAINT "UQ_8082ec4890f892f0bc77473a123" UNIQUE ("dataTableId", "name");



ALTER TABLE ONLY "public"."data_table"
    ADD CONSTRAINT "UQ_b23096ef747281ac944d28e8b0d" UNIQUE ("projectId", "name");



ALTER TABLE ONLY "public"."role_mapping_rule"
    ADD CONSTRAINT "UQ_b33ac896ad3099fc8de36fdc1c4" UNIQUE ("type", "order");



ALTER TABLE ONLY "public"."user_favorites"
    ADD CONSTRAINT "UQ_cf6ae658ead9ffc124723413c65" UNIQUE ("userId", "resourceId", "resourceType");



ALTER TABLE ONLY "public"."user"
    ADD CONSTRAINT "UQ_e12875dfb3b1d92d7d7c5377e2" UNIQUE ("email");



ALTER TABLE ONLY "public"."workflow_builder_session"
    ADD CONSTRAINT "UQ_ec2aa73632932d485a1d5192ce1" UNIQUE ("workflowId", "userId");



ALTER TABLE ONLY "public"."auth_identity"
    ADD CONSTRAINT "auth_identity_pkey" PRIMARY KEY ("providerId", "providerType");



ALTER TABLE ONLY "public"."auth_provider_sync_history"
    ADD CONSTRAINT "auth_provider_sync_history_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."credentials_entity"
    ADD CONSTRAINT "credentials_entity_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."event_destinations"
    ADD CONSTRAINT "event_destinations_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."execution_data"
    ADD CONSTRAINT "execution_data_pkey" PRIMARY KEY ("executionId");



ALTER TABLE ONLY "public"."execution_entity"
    ADD CONSTRAINT "pk_e3e63bbf986767844bbe1166d4e" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."workflows_tags"
    ADD CONSTRAINT "pk_workflows_tags" PRIMARY KEY ("workflowId", "tagId");



ALTER TABLE ONLY "public"."tag_entity"
    ADD CONSTRAINT "tag_entity_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."variables"
    ADD CONSTRAINT "variables_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."workflow_entity"
    ADD CONSTRAINT "workflow_entity_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."workflow_statistics_delta"
    ADD CONSTRAINT "workflow_statistics_delta_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."workflow_statistics"
    ADD CONSTRAINT "workflow_statistics_pkey" PRIMARY KEY ("id");



CREATE INDEX "IDX_02751202c9a2ad75f2d8e14f5e" ON "public"."instance_ai_iteration_logs" USING "btree" ("threadId", "taskKey", "createdAt");



CREATE INDEX "IDX_0468a9dc35597314e641d4722a" ON "public"."agent_execution_threads" USING "btree" ("agentId");



CREATE INDEX "IDX_069e791e428391a5569e7a96b2" ON "public"."agents_memory_entry_cursors" USING "btree" ("observationScopeId");



CREATE INDEX "IDX_070b5de842ece9ccdda0d9738b" ON "public"."workflow_publish_history" USING "btree" ("workflowId", "versionId");



CREATE INDEX "IDX_07cb1e4a302629c5fa5d74d2bb" ON "public"."agents_observations" USING "btree" ("agentId", "observationScopeId", "status");



CREATE INDEX "IDX_0babdf6e3b897a86fe4678355e" ON "public"."instance_ai_pending_confirmations" USING "btree" ("checkpointKey");



CREATE INDEX "IDX_0d5db648188d338df7fb2a8064" ON "public"."instance_ai_observations" USING "btree" ("observationScopeId", "status", "createdAt", "id");



CREATE INDEX "IDX_0e2f8bf92a7a9c88b89670f701" ON "public"."agent_execution_threads" USING "btree" ("projectId");



CREATE INDEX "IDX_0edf1226b77ddc525eae493807" ON "public"."agents_memory_entries" USING "btree" ("supersededBy");



CREATE INDEX "IDX_127ee1078ffa952bb37b511efa" ON "public"."agents_observations" USING "btree" ("supersededBy");



CREATE INDEX "IDX_1443a75e59adbfb796071d6639" ON "public"."agents_memory_entries" USING "btree" ("resourceId");



CREATE UNIQUE INDEX "IDX_14f68deffaf858465715995508" ON "public"."folder" USING "btree" ("projectId", "id");



CREATE UNIQUE INDEX "IDX_16db3adb7b19df1ee55ff06b27" ON "public"."instance_ai_mcp_registry_connections" USING "btree" ("userId", "serverSlug", "credentialId");



CREATE INDEX "IDX_1d11050a381548c42c32cc25c4" ON "public"."user_favorites" USING "btree" ("resourceType", "resourceId");



CREATE UNIQUE INDEX "IDX_1d8ab99d5861c9388d2dc1cf73" ON "public"."insights_metadata" USING "btree" ("workflowId");



CREATE INDEX "IDX_1dd5c393ad0517be3c31a7af83" ON "public"."user_favorites" USING "btree" ("userId");



CREATE INDEX "IDX_1e31657f5fe46816c34be7c1b4" ON "public"."workflow_history" USING "btree" ("workflowId");



CREATE INDEX "IDX_1eeb64cb9d66a927988de759e6" ON "public"."instance_ai_messages" USING "btree" ("threadId");



CREATE UNIQUE INDEX "IDX_1ef35bac35d20bdae979d917a3" ON "public"."user_api_keys" USING "btree" ("apiKey");



CREATE INDEX "IDX_2b23f3f24a70bebb990203b011" ON "public"."instance_ai_checkpoints" USING "btree" ("threadId");



CREATE INDEX "IDX_35a78869286c65d9330d02b88f" ON "public"."role_mapping_rule_project" USING "btree" ("projectId");



CREATE INDEX "IDX_39b07732e819fb561d74c38763" ON "public"."ai_builder_temporary_workflow" USING "btree" ("threadId");



CREATE INDEX "IDX_401b94abf83d1ac7a841f31330" ON "public"."instance_ai_thread_grants" USING "btree" ("userId");



CREATE INDEX "IDX_451d387a182fa8dd8002dfc3a7" ON "public"."agents_memory_entry_sources" USING "btree" ("threadId");



CREATE INDEX "IDX_45dafc48fe2ce95eac30fc8ffd" ON "public"."agent_files" USING "btree" ("agentId", "createdAt");



CREATE UNIQUE INDEX "IDX_4c72ebdb265d1775bf61147af0" ON "public"."chat_hub_tools" USING "btree" ("ownerId", "name");



CREATE INDEX "IDX_4cfd8a70ebb0a5b0cf047dca3c" ON "public"."agents_observations" USING "btree" ("observationScopeId");



CREATE INDEX "IDX_501e2d1701a10e24fb69ab5fc5" ON "public"."agents_observations" USING "btree" ("parentId");



CREATE INDEX "IDX_54fa1b94f34a409beafae567a4" ON "public"."agents_threads" USING "btree" ("resourceId");



CREATE INDEX "IDX_56900edc3cfd16612e2ef2c6a8" ON "public"."binary_data" USING "btree" ("sourceType", "sourceId");



CREATE INDEX "IDX_5e31c210f896d539964bf99fe3" ON "public"."agent_checkpoints" USING "btree" ("agentId");



CREATE INDEX "IDX_5ec8e8c8d3539f3696cf73b43b" ON "public"."credential_dependency" USING "btree" ("credentialId");



CREATE INDEX "IDX_5f0643f6717905a05164090dde" ON "public"."project_relation" USING "btree" ("userId");



CREATE UNIQUE INDEX "IDX_60b6a84299eeb3f671dfec7693" ON "public"."insights_by_period" USING "btree" ("periodStart", "type", "periodUnit", "metaId");



CREATE INDEX "IDX_61448d56d61802b5dfde5cdb00" ON "public"."project_relation" USING "btree" ("projectId");



CREATE INDEX "IDX_62476b94b56d9dc7ed9ed75d3d" ON "public"."dynamic_credential_entry" USING "btree" ("subject_id");



CREATE INDEX "IDX_63d3c3a68b9cebf05f967f0b1c" ON "public"."agent_execution" USING "btree" ("threadId", "createdAt");



CREATE UNIQUE INDEX "IDX_63d7bbae72c767cf162d459fcc" ON "public"."user_api_keys" USING "btree" ("userId", "label");



CREATE INDEX "IDX_6b55089892e447c2f82e5ec60e" ON "public"."agents_observation_locks" USING "btree" ("observationScopeId");



CREATE INDEX "IDX_6edec973a6450990977bb854c3" ON "public"."dynamic_credential_user_entry" USING "btree" ("resolverId");



CREATE INDEX "IDX_768189b506cc26c4fe878b87cb" ON "public"."instance_ai_checkpoints" USING "btree" ("runId");



CREATE INDEX "IDX_76e212c6867fbaa06bf0decd6f" ON "public"."instance_ai_messages" USING "btree" ("resourceId");



CREATE INDEX "IDX_87aa187d27ea67eafd16490515" ON "public"."agents_observation_cursors" USING "btree" ("observationScopeId");



CREATE INDEX "IDX_87cd5a8da20304b089ea2f83fe" ON "public"."agent_history" USING "btree" ("agentId");



CREATE INDEX "IDX_8e4b4774db42f1e6dda3452b2a" ON "public"."test_case_execution" USING "btree" ("testRunId");



CREATE INDEX "IDX_91ee85fa9619dd6776725e117b" ON "public"."credential_dependency" USING "btree" ("dependencyType", "dependencyId");



CREATE INDEX "IDX_92f13cb6bc694227e069447f7b" ON "public"."instance_ai_observational_memory" USING "btree" ("lookupKey");



CREATE INDEX "IDX_9594c0983cfee1c8ff49b05848" ON "public"."agents_memory_entry_locks" USING "btree" ("resourceId");



CREATE UNIQUE INDEX "IDX_97f863fa83c4786f1956508496" ON "public"."execution_annotations" USING "btree" ("executionId");



CREATE INDEX "IDX_9c9ee9df586e60bb723234e499" ON "public"."dynamic_credential_resolver" USING "btree" ("type");



CREATE UNIQUE INDEX "IDX_UniqueRoleDisplayName" ON "public"."role" USING "btree" ("displayName");



CREATE UNIQUE INDEX "IDX_a03e04e94bea8439dd166d4b52" ON "public"."agents_memory_entries" USING "btree" ("agentId", "resourceId", "contentHash");



CREATE INDEX "IDX_a30d560207c4071d98aa03c179" ON "public"."agents" USING "btree" ("projectId");



CREATE UNIQUE INDEX "IDX_a353ac251315ef0af6ad3c9f0a" ON "public"."agents_memory_entry_sources" USING "btree" ("memoryEntryId", "observationId", "evidenceHash");



CREATE INDEX "IDX_a3697779b366e131b2bbdae297" ON "public"."execution_annotation_tags" USING "btree" ("tagId");



CREATE INDEX "IDX_a36dc616fabc3f736bb82410a2" ON "public"."dynamic_credential_user_entry" USING "btree" ("userId");



CREATE INDEX "IDX_a371ee6b8e0ebb5635f8baa46d" ON "public"."instance_ai_workflow_snapshots" USING "btree" ("workflowName", "status");



CREATE INDEX "IDX_a48ce930c3bc7604894b8f0eaa" ON "public"."evaluation_collection" USING "btree" ("workflowId");



CREATE INDEX "IDX_a4ff2d9b9628ea988fa9e7d0bf" ON "public"."workflow_dependency" USING "btree" ("workflowId");



CREATE UNIQUE INDEX "IDX_a680ac96aae02dc887bbaac512" ON "public"."instance_ai_observational_memory" USING "btree" ("scope", "threadId", "resourceId");



CREATE INDEX "IDX_a80e0ee839a2f10ba4b86e1999" ON "public"."instance_ai_observations" USING "btree" ("supersededBy");



CREATE UNIQUE INDEX "IDX_ae51b54c4bb430cf92f48b623f" ON "public"."annotation_tag_entity" USING "btree" ("name");



CREATE INDEX "IDX_aff2807b31eccbafe59d0474f0" ON "public"."agents_memory_entries" USING "btree" ("agentId", "resourceId", "status", "createdAt", "id");



CREATE INDEX "IDX_agent_execution_threads_taskVersionId" ON "public"."agent_execution_threads" USING "btree" ("taskVersionId");



CREATE UNIQUE INDEX "IDX_agent_files_agentId_binaryDataId" ON "public"."agent_files" USING "btree" ("agentId", "binaryDataId");



CREATE UNIQUE INDEX "IDX_agent_files_agentId_fileName" ON "public"."agent_files" USING "btree" ("agentId", "fileName");



CREATE INDEX "IDX_agents_messages_threadId_createdAt" ON "public"."agents_messages" USING "btree" ("threadId", "createdAt");



CREATE INDEX "IDX_agents_projectId" ON "public"."agents" USING "btree" ("projectId");



CREATE INDEX "IDX_ba67ee8dc311830a2eea89b6e9" ON "public"."instance_ai_pending_confirmations" USING "btree" ("threadId");



CREATE INDEX "IDX_bb66e404c35996b0d694617750" ON "public"."role_mapping_rule" USING "btree" ("role");



CREATE INDEX "IDX_be9d0eca0b19fb93d4eb74b327" ON "public"."instance_ai_checkpoints" USING "btree" ("resourceId");



CREATE INDEX "IDX_c1519757391996eb06064f0e7c" ON "public"."execution_annotation_tags" USING "btree" ("annotationId");



CREATE INDEX "IDX_cb7c15d22fd068a0806aa57fc0" ON "public"."agents_memory_entry_sources" USING "btree" ("observationId");



CREATE UNIQUE INDEX "IDX_cec8eea3bf49551482ccb4933e" ON "public"."execution_metadata" USING "btree" ("executionId", "key");



CREATE INDEX "IDX_chat_hub_messages_sessionId" ON "public"."chat_hub_messages" USING "btree" ("sessionId");



CREATE INDEX "IDX_chat_hub_sessions_owner_lastmsg_id" ON "public"."chat_hub_sessions" USING "btree" ("ownerId", "lastMessageAt" DESC, "id");



CREATE UNIQUE INDEX "IDX_credential_dependency_credentialId_dependencyType_dependenc" ON "public"."credential_dependency" USING "btree" ("credentialId", "dependencyType", "dependencyId");



CREATE INDEX "IDX_credentials_entity_is_global" ON "public"."credentials_entity" USING "btree" ("id") WHERE ("isGlobal" = true);



CREATE INDEX "IDX_d3a2bc880e7a8626802e5474ad" ON "public"."instance_ai_run_snapshots" USING "btree" ("threadId", "createdAt");



CREATE INDEX "IDX_d61a12235d268a49af6a3c09c1" ON "public"."dynamic_credential_entry" USING "btree" ("resolver_id");



CREATE INDEX "IDX_d634a0c93fd7de68a87eab951b" ON "public"."evaluation_collection" USING "btree" ("evaluationConfigId");



CREATE INDEX "IDX_d6870d3b6e4c185d33926f423c" ON "public"."test_run" USING "btree" ("workflowId");



CREATE INDEX "IDX_d7a4aba7440449865e2b924377" ON "public"."instance_ai_pending_confirmations" USING "btree" ("expiresAt");



CREATE INDEX "IDX_d926c16c2ad9728cb9a81790c0" ON "public"."instance_ai_run_snapshots" USING "btree" ("threadId", "messageGroupId");



CREATE INDEX "IDX_daef2195a4a846eb70eed15e03" ON "public"."instance_ai_observations" USING "btree" ("parentId");



CREATE UNIQUE INDEX "IDX_deployment_key_data_encryption_active" ON "public"."deployment_key" USING "btree" ("type") WHERE ((("status")::"text" = 'active'::"text") AND (("type")::"text" = 'data_encryption'::"text"));



CREATE UNIQUE INDEX "IDX_deployment_key_instance_id_active" ON "public"."deployment_key" USING "btree" ("type") WHERE ((("status")::"text" = 'active'::"text") AND (("type")::"text" = 'instance.id'::"text"));



CREATE UNIQUE INDEX "IDX_deployment_key_jwe_private_key_active" ON "public"."deployment_key" USING "btree" ("type", "algorithm") WHERE ((("status")::"text" = 'active'::"text") AND (("type")::"text" = 'jwe.private-key'::"text"));



CREATE UNIQUE INDEX "IDX_deployment_key_signing_binary_data_active" ON "public"."deployment_key" USING "btree" ("type") WHERE ((("status")::"text" = 'active'::"text") AND (("type")::"text" = 'signing.binary_data'::"text"));



CREATE UNIQUE INDEX "IDX_deployment_key_signing_hmac_active" ON "public"."deployment_key" USING "btree" ("type") WHERE ((("status")::"text" = 'active'::"text") AND (("type")::"text" = 'signing.hmac'::"text"));



CREATE UNIQUE INDEX "IDX_deployment_key_signing_jwt_active" ON "public"."deployment_key" USING "btree" ("type") WHERE ((("status")::"text" = 'active'::"text") AND (("type")::"text" = 'signing.jwt'::"text"));



CREATE INDEX "IDX_df5fd25c8bbfd2b042602600d8" ON "public"."instance_ai_pending_confirmations" USING "btree" ("userId");



CREATE INDEX "IDX_e48a201071ab85d9d09119d640" ON "public"."workflow_dependency" USING "btree" ("dependencyKey");



CREATE INDEX "IDX_e7fe1cfda990c14a445937d0b9" ON "public"."workflow_dependency" USING "btree" ("dependencyType");



CREATE UNIQUE INDEX "IDX_execution_entity_deduplicationKey" ON "public"."execution_entity" USING "btree" ("deduplicationKey") WHERE ("deduplicationKey" IS NOT NULL);



CREATE INDEX "IDX_execution_entity_deletedAt" ON "public"."execution_entity" USING "btree" ("deletedAt");



CREATE INDEX "IDX_execution_entity_workflowId_status_id" ON "public"."execution_entity" USING "btree" ("workflowId", "status", "id") WHERE ("deletedAt" IS NULL);



CREATE INDEX "IDX_f36dea4d38fe92e0e8f44d5a56" ON "public"."instance_ai_threads" USING "btree" ("resourceId");



CREATE INDEX "IDX_f45d0535a2ed59b6c2dd6da98a" ON "public"."agent_task_definition" USING "btree" ("agentId");



CREATE INDEX "IDX_f9573af4ed653f13b0ba1f7b12" ON "public"."agents_memory_entry_sources" USING "btree" ("agentId", "threadId");



CREATE INDEX "IDX_fc7bf858660bfafd19181e8e35" ON "public"."agents_messages" USING "btree" ("threadId", "createdAt");



CREATE INDEX "IDX_fd7542bb123074760285dc1bbf" ON "public"."evaluation_config" USING "btree" ("workflowId");



CREATE INDEX "IDX_insights_raw_timestamp_id" ON "public"."insights_raw" USING "btree" ("timestamp", "id");



CREATE INDEX "IDX_instance_ai_threads_projectId" ON "public"."instance_ai_threads" USING "btree" ("projectId");



CREATE INDEX "IDX_role_scope_scopeSlug" ON "public"."role_scope" USING "btree" ("scopeSlug");



CREATE UNIQUE INDEX "IDX_scheduled_job_name" ON "public"."scheduled_job" USING "btree" ("name");



CREATE INDEX "IDX_scheduled_job_nextRunAt" ON "public"."scheduled_job" USING "btree" ("nextRunAt") WHERE (("enabled" = true) AND ("nextRunAt" IS NOT NULL));



CREATE INDEX "IDX_scheduled_job_workflowId" ON "public"."scheduled_job" USING "btree" ("workflowId") WHERE ("workflowId" IS NOT NULL);



CREATE INDEX "IDX_scheduled_task_finishedAt" ON "public"."scheduled_task" USING "btree" ("finishedAt") WHERE ("finishedAt" IS NOT NULL);



CREATE UNIQUE INDEX "IDX_scheduled_task_jobId_scheduledFor" ON "public"."scheduled_task" USING "btree" ("jobId", "scheduledFor");



CREATE INDEX "IDX_scheduled_task_leaseExpiresAt" ON "public"."scheduled_task" USING "btree" ("leaseExpiresAt") WHERE (("status")::"text" = 'running'::"text");



CREATE INDEX "IDX_scheduled_task_runAt" ON "public"."scheduled_task" USING "btree" ("runAt") WHERE (("status")::"text" = 'pending'::"text");



CREATE UNIQUE INDEX "IDX_secrets_provider_connection_providerKey" ON "public"."secrets_provider_connection" USING "btree" ("providerKey");



CREATE INDEX "IDX_shared_workflow_projectId" ON "public"."shared_workflow" USING "btree" ("projectId");



CREATE INDEX "IDX_test_run_collectionId" ON "public"."test_run" USING "btree" ("collectionId");



CREATE INDEX "IDX_test_run_evaluationConfigId" ON "public"."test_run" USING "btree" ("evaluationConfigId");



CREATE INDEX "IDX_workflow_dependency_publishedVersionId" ON "public"."workflow_dependency" USING "btree" ("publishedVersionId");



CREATE INDEX "IDX_workflow_entity_name" ON "public"."workflow_entity" USING "btree" ("name");



CREATE INDEX "IDX_workflow_entity_sourceWorkflowId" ON "public"."workflow_entity" USING "btree" ("sourceWorkflowId") WHERE ("sourceWorkflowId" IS NOT NULL);



CREATE UNIQUE INDEX "IDX_workflow_publication_outbox_active_workflow_status" ON "public"."workflow_publication_outbox" USING "btree" ("workflowId", "status") WHERE (("status")::"text" = ANY ((ARRAY['pending'::character varying, 'in_progress'::character varying])::"text"[]));



CREATE UNIQUE INDEX "IDX_workflow_statistics_workflow_name" ON "public"."workflow_statistics" USING "btree" ("workflowId", "name");



CREATE INDEX "idx_07fde106c0b471d8cc80a64fc8" ON "public"."credentials_entity" USING "btree" ("type");



CREATE INDEX "idx_16f4436789e804e3e1c9eeb240" ON "public"."webhook_entity" USING "btree" ("webhookId", "method", "pathLength");



CREATE UNIQUE INDEX "idx_812eb05f7451ca757fb98444ce" ON "public"."tag_entity" USING "btree" ("name");



CREATE INDEX "idx_execution_entity_stopped_at_status_deleted_at" ON "public"."execution_entity" USING "btree" ("stoppedAt", "status", "deletedAt") WHERE (("stoppedAt" IS NOT NULL) AND ("deletedAt" IS NULL));



CREATE INDEX "idx_execution_entity_wait_till_status_deleted_at" ON "public"."execution_entity" USING "btree" ("waitTill", "status", "deletedAt") WHERE (("waitTill" IS NOT NULL) AND ("deletedAt" IS NULL));



CREATE INDEX "idx_execution_entity_workflow_id_started_at" ON "public"."execution_entity" USING "btree" ("workflowId", "startedAt") WHERE (("startedAt" IS NOT NULL) AND ("deletedAt" IS NULL));



CREATE INDEX "idx_workflows_tags_workflow_id" ON "public"."workflows_tags" USING "btree" ("workflowId");



CREATE UNIQUE INDEX "pk_credentials_entity_id" ON "public"."credentials_entity" USING "btree" ("id");



CREATE UNIQUE INDEX "pk_tag_entity_id" ON "public"."tag_entity" USING "btree" ("id");



CREATE UNIQUE INDEX "pk_workflow_entity_id" ON "public"."workflow_entity" USING "btree" ("id");



CREATE INDEX "project_relation_role_idx" ON "public"."project_relation" USING "btree" ("role");



CREATE INDEX "project_relation_role_project_idx" ON "public"."project_relation" USING "btree" ("projectId", "role");



CREATE INDEX "user_role_idx" ON "public"."user" USING "btree" ("roleSlug");



CREATE UNIQUE INDEX "variables_global_key_unique" ON "public"."variables" USING "btree" ("key") WHERE ("projectId" IS NULL);



CREATE UNIQUE INDEX "variables_project_key_unique" ON "public"."variables" USING "btree" ("projectId", "key") WHERE ("projectId" IS NOT NULL);



CREATE OR REPLACE TRIGGER "workflow_version_increment" BEFORE UPDATE ON "public"."workflow_entity" FOR EACH ROW EXECUTE FUNCTION "public"."increment_workflow_version"();



ALTER TABLE ONLY "public"."workflow_builder_session"
    ADD CONSTRAINT "FK_00290cdeee4d4d7db84709be936" FOREIGN KEY ("userId") REFERENCES "public"."user"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."agent_execution_threads"
    ADD CONSTRAINT "FK_0468a9dc35597314e641d4722aa" FOREIGN KEY ("agentId") REFERENCES "public"."agents"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."agents_memory_entry_cursors"
    ADD CONSTRAINT "FK_069e791e428391a5569e7a96b20" FOREIGN KEY ("observationScopeId") REFERENCES "public"."agents_threads"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."processed_data"
    ADD CONSTRAINT "FK_06a69a7032c97a763c2c7599464" FOREIGN KEY ("workflowId") REFERENCES "public"."workflow_entity"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."workflow_entity"
    ADD CONSTRAINT "FK_08d6c67b7f722b0039d9d5ed620" FOREIGN KEY ("activeVersionId") REFERENCES "public"."workflow_history"("versionId") ON DELETE RESTRICT;



ALTER TABLE ONLY "public"."agents_observation_locks"
    ADD CONSTRAINT "FK_093e44ae20f2518e97d83a95433" FOREIGN KEY ("agentId") REFERENCES "public"."agents"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."agents_messages"
    ADD CONSTRAINT "FK_0a8057a61afabd2999608ffd0d9" FOREIGN KEY ("threadId") REFERENCES "public"."agents_threads"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."instance_ai_pending_confirmations"
    ADD CONSTRAINT "FK_0babdf6e3b897a86fe4678355eb" FOREIGN KEY ("checkpointKey") REFERENCES "public"."instance_ai_checkpoints"("key") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."agents_memory_entry_locks"
    ADD CONSTRAINT "FK_0ccf6d9ea6f44fa1c264fc2f795" FOREIGN KEY ("agentId") REFERENCES "public"."agents"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."agent_execution_threads"
    ADD CONSTRAINT "FK_0e2f8bf92a7a9c88b89670f701c" FOREIGN KEY ("projectId") REFERENCES "public"."project"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."agents_memory_entries"
    ADD CONSTRAINT "FK_0edf1226b77ddc525eae4938079" FOREIGN KEY ("supersededBy") REFERENCES "public"."agents_memory_entries"("id");



ALTER TABLE ONLY "public"."instance_ai_observation_locks"
    ADD CONSTRAINT "FK_103e2e5f454860b28ea05a82c74" FOREIGN KEY ("observationScopeId") REFERENCES "public"."instance_ai_threads"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."agents_observations"
    ADD CONSTRAINT "FK_127ee1078ffa952bb37b511efad" FOREIGN KEY ("supersededBy") REFERENCES "public"."agents_observations"("id");



ALTER TABLE ONLY "public"."agents_memory_entries"
    ADD CONSTRAINT "FK_1443a75e59adbfb796071d66393" FOREIGN KEY ("resourceId") REFERENCES "public"."agents_resources"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."project_secrets_provider_access"
    ADD CONSTRAINT "FK_18e5c27d2524b1638b292904e48" FOREIGN KEY ("secretsProviderConnectionId") REFERENCES "public"."secrets_provider_connection"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."agent_task_snapshot"
    ADD CONSTRAINT "FK_1acedce6690392ef1611cca8b88" FOREIGN KEY ("versionId") REFERENCES "public"."agent_history"("versionId") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."instance_ai_mcp_registry_connections"
    ADD CONSTRAINT "FK_1d25707354d2012da256eb2ec0a" FOREIGN KEY ("serverSlug") REFERENCES "public"."mcp_registry_server"("slug") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."insights_metadata"
    ADD CONSTRAINT "FK_1d8ab99d5861c9388d2dc1cf733" FOREIGN KEY ("workflowId") REFERENCES "public"."workflow_entity"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."user_favorites"
    ADD CONSTRAINT "FK_1dd5c393ad0517be3c31a7af836" FOREIGN KEY ("userId") REFERENCES "public"."user"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."workflow_history"
    ADD CONSTRAINT "FK_1e31657f5fe46816c34be7c1b4b" FOREIGN KEY ("workflowId") REFERENCES "public"."workflow_entity"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."instance_ai_mcp_registry_connections"
    ADD CONSTRAINT "FK_1e826120e7e53ebc4681f026de8" FOREIGN KEY ("credentialId") REFERENCES "public"."credentials_entity"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."instance_ai_messages"
    ADD CONSTRAINT "FK_1eeb64cb9d66a927988de759e6e" FOREIGN KEY ("threadId") REFERENCES "public"."instance_ai_threads"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."chat_hub_messages"
    ADD CONSTRAINT "FK_1f4998c8a7dec9e00a9ab15550e" FOREIGN KEY ("revisionOfMessageId") REFERENCES "public"."chat_hub_messages"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."oauth_user_consents"
    ADD CONSTRAINT "FK_21e6c3c2d78a097478fae6aaefa" FOREIGN KEY ("userId") REFERENCES "public"."user"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."insights_metadata"
    ADD CONSTRAINT "FK_2375a1eda085adb16b24615b69c" FOREIGN KEY ("projectId") REFERENCES "public"."project"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."chat_hub_messages"
    ADD CONSTRAINT "FK_25c9736e7f769f3a005eef4b372" FOREIGN KEY ("retryOfMessageId") REFERENCES "public"."chat_hub_messages"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."agents_memory_entries"
    ADD CONSTRAINT "FK_28e981fb675e9b44ce02f0ec1dd" FOREIGN KEY ("agentId") REFERENCES "public"."agents"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."instance_ai_checkpoints"
    ADD CONSTRAINT "FK_2b23f3f24a70bebb990203b011e" FOREIGN KEY ("threadId") REFERENCES "public"."instance_ai_threads"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."chat_hub_agent_tools"
    ADD CONSTRAINT "FK_2b53d796b3dbae91b1a9553c048" FOREIGN KEY ("agentId") REFERENCES "public"."chat_hub_agents"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."instance_ai_run_snapshots"
    ADD CONSTRAINT "FK_2f63fa21d09d7918f347ddbdf70" FOREIGN KEY ("threadId") REFERENCES "public"."instance_ai_threads"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."execution_metadata"
    ADD CONSTRAINT "FK_31d0b4c93fb85ced26f6005cda3" FOREIGN KEY ("executionId") REFERENCES "public"."execution_entity"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."instance_ai_observational_memory"
    ADD CONSTRAINT "FK_34018c303885cd37093458e6409" FOREIGN KEY ("threadId") REFERENCES "public"."instance_ai_threads"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."role_mapping_rule_project"
    ADD CONSTRAINT "FK_35a78869286c65d9330d02b88f5" FOREIGN KEY ("projectId") REFERENCES "public"."project"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."ai_builder_temporary_workflow"
    ADD CONSTRAINT "FK_39b07732e819fb561d74c38763f" FOREIGN KEY ("threadId") REFERENCES "public"."instance_ai_threads"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."instance_ai_thread_grants"
    ADD CONSTRAINT "FK_401b94abf83d1ac7a841f31330e" FOREIGN KEY ("userId") REFERENCES "public"."user"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."shared_credentials"
    ADD CONSTRAINT "FK_416f66fc846c7c442970c094ccf" FOREIGN KEY ("credentialsId") REFERENCES "public"."credentials_entity"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."variables"
    ADD CONSTRAINT "FK_42f6c766f9f9d2edcc15bdd6e9b" FOREIGN KEY ("projectId") REFERENCES "public"."project"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."chat_hub_agent_tools"
    ADD CONSTRAINT "FK_43e70f04c53344f82483d0570f6" FOREIGN KEY ("toolId") REFERENCES "public"."chat_hub_tools"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."chat_hub_agents"
    ADD CONSTRAINT "FK_441ba2caba11e077ce3fbfa2cd8" FOREIGN KEY ("ownerId") REFERENCES "public"."user"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."agents_memory_entry_sources"
    ADD CONSTRAINT "FK_451d387a182fa8dd8002dfc3a77" FOREIGN KEY ("threadId") REFERENCES "public"."agents_threads"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."agents_memory_entry_sources"
    ADD CONSTRAINT "FK_4706f6223313959b7437a2b48df" FOREIGN KEY ("memoryEntryId") REFERENCES "public"."agents_memory_entries"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."agents_observations"
    ADD CONSTRAINT "FK_4cfd8a70ebb0a5b0cf047dca3cf" FOREIGN KEY ("observationScopeId") REFERENCES "public"."agents_threads"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."agents_observations"
    ADD CONSTRAINT "FK_501e2d1701a10e24fb69ab5fc5f" FOREIGN KEY ("parentId") REFERENCES "public"."agents_observations"("id");



ALTER TABLE ONLY "public"."instance_ai_observation_cursors"
    ADD CONSTRAINT "FK_5b6319b2e9a37c1064a72428f9a" FOREIGN KEY ("observationScopeId") REFERENCES "public"."instance_ai_threads"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."workflow_published_version"
    ADD CONSTRAINT "FK_5c76fb7ee939fe2530374d3f75a" FOREIGN KEY ("workflowId") REFERENCES "public"."workflow_entity"("id") ON DELETE RESTRICT;



ALTER TABLE ONLY "public"."agent_checkpoints"
    ADD CONSTRAINT "FK_5e31c210f896d539964bf99fe32" FOREIGN KEY ("agentId") REFERENCES "public"."agents"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."credential_dependency"
    ADD CONSTRAINT "FK_5ec8e8c8d3539f3696cf73b43bf" FOREIGN KEY ("credentialId") REFERENCES "public"."credentials_entity"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."project_relation"
    ADD CONSTRAINT "FK_5f0643f6717905a05164090dde7" FOREIGN KEY ("userId") REFERENCES "public"."user"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."project_relation"
    ADD CONSTRAINT "FK_61448d56d61802b5dfde5cdb002" FOREIGN KEY ("projectId") REFERENCES "public"."project"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."insights_by_period"
    ADD CONSTRAINT "FK_6414cfed98daabbfdd61a1cfbc0" FOREIGN KEY ("metaId") REFERENCES "public"."insights_metadata"("metaId") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."oauth_authorization_codes"
    ADD CONSTRAINT "FK_64d965bd072ea24fb6da55468cd" FOREIGN KEY ("clientId") REFERENCES "public"."oauth_clients"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."agents_observation_cursors"
    ADD CONSTRAINT "FK_64e92819f4b413661ed6e2c3c3d" FOREIGN KEY ("agentId") REFERENCES "public"."agents"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."chat_hub_session_tools"
    ADD CONSTRAINT "FK_6596a328affd8d4967ffb303eee" FOREIGN KEY ("toolId") REFERENCES "public"."chat_hub_tools"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."chat_hub_messages"
    ADD CONSTRAINT "FK_6afb260449dd7a9b85355d4e0c9" FOREIGN KEY ("executionId") REFERENCES "public"."execution_entity"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."agents_observation_locks"
    ADD CONSTRAINT "FK_6b55089892e447c2f82e5ec60ed" FOREIGN KEY ("observationScopeId") REFERENCES "public"."agents_threads"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."insights_raw"
    ADD CONSTRAINT "FK_6e2e33741adef2a7c5d66befa4e" FOREIGN KEY ("metaId") REFERENCES "public"."insights_metadata"("metaId") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."workflow_publish_history"
    ADD CONSTRAINT "FK_6eab5bd9eedabe9c54bd879fc40" FOREIGN KEY ("userId") REFERENCES "public"."user"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."dynamic_credential_user_entry"
    ADD CONSTRAINT "FK_6edec973a6450990977bb854c38" FOREIGN KEY ("resolverId") REFERENCES "public"."dynamic_credential_resolver"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."oauth_access_tokens"
    ADD CONSTRAINT "FK_7234a36d8e49a1fa85095328845" FOREIGN KEY ("userId") REFERENCES "public"."user"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."installed_nodes"
    ADD CONSTRAINT "FK_73f857fc5dce682cef8a99c11dbddbc969618951" FOREIGN KEY ("package") REFERENCES "public"."installed_packages"("packageName") ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY "public"."agents_memory_entry_cursors"
    ADD CONSTRAINT "FK_746780fd115e5e4352457a3c617" FOREIGN KEY ("agentId") REFERENCES "public"."agents"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."oauth_access_tokens"
    ADD CONSTRAINT "FK_78b26968132b7e5e45b75876481" FOREIGN KEY ("clientId") REFERENCES "public"."oauth_clients"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."workflow_builder_session"
    ADD CONSTRAINT "FK_7983c618db48f47bf5a4cc1e1e4" FOREIGN KEY ("workflowId") REFERENCES "public"."workflow_entity"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."chat_hub_sessions"
    ADD CONSTRAINT "FK_7bc13b4c7e6afbfaf9be326c189" FOREIGN KEY ("credentialId") REFERENCES "public"."credentials_entity"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."folder"
    ADD CONSTRAINT "FK_804ea52f6729e3940498bd54d78" FOREIGN KEY ("parentFolderId") REFERENCES "public"."folder"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."shared_credentials"
    ADD CONSTRAINT "FK_812c2852270da1247756e77f5a4" FOREIGN KEY ("projectId") REFERENCES "public"."project"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."ai_builder_temporary_workflow"
    ADD CONSTRAINT "FK_85a87a1ba0f61999fe11dc56325" FOREIGN KEY ("workflowId") REFERENCES "public"."workflow_entity"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."agent_history"
    ADD CONSTRAINT "FK_8771675f44c58fb40e0feb9ee35" FOREIGN KEY ("publishedById") REFERENCES "public"."user"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."agents_observation_cursors"
    ADD CONSTRAINT "FK_87aa187d27ea67eafd164905154" FOREIGN KEY ("observationScopeId") REFERENCES "public"."agents_threads"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."agent_history"
    ADD CONSTRAINT "FK_87cd5a8da20304b089ea2f83fec" FOREIGN KEY ("agentId") REFERENCES "public"."agents"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."instance_ai_mcp_registry_connections"
    ADD CONSTRAINT "FK_8b42c08a531d76410980c639a5b" FOREIGN KEY ("userId") REFERENCES "public"."user"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."instance_ai_iteration_logs"
    ADD CONSTRAINT "FK_8bfcc6c51fd3d69b1eae8aebd49" FOREIGN KEY ("threadId") REFERENCES "public"."instance_ai_threads"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."trusted_key"
    ADD CONSTRAINT "FK_8c2938d746943dd8f608d23c891" FOREIGN KEY ("sourceId") REFERENCES "public"."trusted_key_source"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."test_case_execution"
    ADD CONSTRAINT "FK_8e4b4774db42f1e6dda3452b2af" FOREIGN KEY ("testRunId") REFERENCES "public"."test_run"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."instance_ai_thread_grants"
    ADD CONSTRAINT "FK_908202dbc0a9b52f669c11d730c" FOREIGN KEY ("threadId") REFERENCES "public"."instance_ai_threads"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."data_table_column"
    ADD CONSTRAINT "FK_930b6e8faaf88294cef23484160" FOREIGN KEY ("dataTableId") REFERENCES "public"."data_table"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."agents"
    ADD CONSTRAINT "FK_940597dfe9753375309ce6aeea0" FOREIGN KEY ("activeVersionId") REFERENCES "public"."agent_history"("versionId") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."dynamic_credential_user_entry"
    ADD CONSTRAINT "FK_945ba70b342a066d1306b12ccd2" FOREIGN KEY ("credentialId") REFERENCES "public"."credentials_entity"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."folder_tag"
    ADD CONSTRAINT "FK_94a60854e06f2897b2e0d39edba" FOREIGN KEY ("folderId") REFERENCES "public"."folder"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."agents_memory_entry_locks"
    ADD CONSTRAINT "FK_9594c0983cfee1c8ff49b05848b" FOREIGN KEY ("resourceId") REFERENCES "public"."agents_resources"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."execution_annotations"
    ADD CONSTRAINT "FK_97f863fa83c4786f19565084960" FOREIGN KEY ("executionId") REFERENCES "public"."execution_entity"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."chat_hub_agents"
    ADD CONSTRAINT "FK_9c61ad497dcbae499c96a6a78ba" FOREIGN KEY ("credentialId") REFERENCES "public"."credentials_entity"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."chat_hub_sessions"
    ADD CONSTRAINT "FK_9f9293d9f552496c40e0d1a8f80" FOREIGN KEY ("workflowId") REFERENCES "public"."workflow_entity"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."agents"
    ADD CONSTRAINT "FK_a30d560207c4071d98aa03c179c" FOREIGN KEY ("projectId") REFERENCES "public"."project"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."execution_annotation_tags"
    ADD CONSTRAINT "FK_a3697779b366e131b2bbdae2976" FOREIGN KEY ("tagId") REFERENCES "public"."annotation_tag_entity"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."dynamic_credential_user_entry"
    ADD CONSTRAINT "FK_a36dc616fabc3f736bb82410a22" FOREIGN KEY ("userId") REFERENCES "public"."user"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."shared_workflow"
    ADD CONSTRAINT "FK_a45ea5f27bcfdc21af9b4188560" FOREIGN KEY ("projectId") REFERENCES "public"."project"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."evaluation_collection"
    ADD CONSTRAINT "FK_a48ce930c3bc7604894b8f0eaad" FOREIGN KEY ("workflowId") REFERENCES "public"."workflow_entity"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."workflow_dependency"
    ADD CONSTRAINT "FK_a4ff2d9b9628ea988fa9e7d0bf8" FOREIGN KEY ("workflowId") REFERENCES "public"."workflow_entity"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."oauth_user_consents"
    ADD CONSTRAINT "FK_a651acea2f6c97f8c4514935486" FOREIGN KEY ("clientId") REFERENCES "public"."oauth_clients"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."oauth_refresh_tokens"
    ADD CONSTRAINT "FK_a699f3ed9fd0c1b19bc2608ac53" FOREIGN KEY ("userId") REFERENCES "public"."user"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."dynamic_credential_entry"
    ADD CONSTRAINT "FK_a6d1dd080958304a47a02952aab" FOREIGN KEY ("credential_id") REFERENCES "public"."credentials_entity"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."instance_ai_observations"
    ADD CONSTRAINT "FK_a80e0ee839a2f10ba4b86e19998" FOREIGN KEY ("supersededBy") REFERENCES "public"."instance_ai_observations"("id");



ALTER TABLE ONLY "public"."folder"
    ADD CONSTRAINT "FK_a8260b0b36939c6247f385b8221" FOREIGN KEY ("projectId") REFERENCES "public"."project"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."oauth_authorization_codes"
    ADD CONSTRAINT "FK_aa8d3560484944c19bdf79ffa16" FOREIGN KEY ("userId") REFERENCES "public"."user"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."agent_files"
    ADD CONSTRAINT "FK_aca4514cb500494b64356c2e164" FOREIGN KEY ("agentId") REFERENCES "public"."agents"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."chat_hub_messages"
    ADD CONSTRAINT "FK_acf8926098f063cdbbad8497fd1" FOREIGN KEY ("workflowId") REFERENCES "public"."workflow_entity"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."agent_execution"
    ADD CONSTRAINT "FK_add2432fb6034cc18b6af299dce" FOREIGN KEY ("threadId") REFERENCES "public"."agent_execution_threads"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."oauth_refresh_tokens"
    ADD CONSTRAINT "FK_b388696ce4d8be7ffbe8d3e4b69" FOREIGN KEY ("clientId") REFERENCES "public"."oauth_clients"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."workflow_publish_history"
    ADD CONSTRAINT "FK_b4cfbc7556d07f36ca177f5e473" FOREIGN KEY ("versionId") REFERENCES "public"."workflow_history"("versionId") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."agent_task_run_lock"
    ADD CONSTRAINT "FK_b57a2862ae869aab24e54cefd48" FOREIGN KEY ("agentId") REFERENCES "public"."agents"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."workflow_publication_trigger_status"
    ADD CONSTRAINT "FK_b7b496d8d1a21158c65f475cd88" FOREIGN KEY ("workflowId") REFERENCES "public"."workflow_entity"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."chat_hub_tools"
    ADD CONSTRAINT "FK_b8030b47af9213f1fd15450fb7f" FOREIGN KEY ("ownerId") REFERENCES "public"."user"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."instance_ai_pending_confirmations"
    ADD CONSTRAINT "FK_ba67ee8dc311830a2eea89b6e96" FOREIGN KEY ("threadId") REFERENCES "public"."instance_ai_threads"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."role_mapping_rule"
    ADD CONSTRAINT "FK_bb66e404c35996b0d6946177501" FOREIGN KEY ("role") REFERENCES "public"."role"("slug") ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY "public"."project_secrets_provider_access"
    ADD CONSTRAINT "FK_bd264b81209355b543878deedb1" FOREIGN KEY ("projectId") REFERENCES "public"."project"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."workflow_publish_history"
    ADD CONSTRAINT "FK_c01316f8c2d7101ec4fa9809267" FOREIGN KEY ("workflowId") REFERENCES "public"."workflow_entity"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."execution_annotation_tags"
    ADD CONSTRAINT "FK_c1519757391996eb06064f0e7c8" FOREIGN KEY ("annotationId") REFERENCES "public"."execution_annotations"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."data_table"
    ADD CONSTRAINT "FK_c2a794257dee48af7c9abf681de" FOREIGN KEY ("projectId") REFERENCES "public"."project"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."agents_memory_entry_sources"
    ADD CONSTRAINT "FK_c38e8a57a36b880e39a52ada2e8" FOREIGN KEY ("agentId") REFERENCES "public"."agents"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."project_relation"
    ADD CONSTRAINT "FK_c6b99592dc96b0d836d7a21db91" FOREIGN KEY ("role") REFERENCES "public"."role"("slug");



ALTER TABLE ONLY "public"."agents_memory_entry_sources"
    ADD CONSTRAINT "FK_cb7c15d22fd068a0806aa57fc03" FOREIGN KEY ("observationId") REFERENCES "public"."agents_observations"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."chat_hub_messages"
    ADD CONSTRAINT "FK_chat_hub_messages_agentId" FOREIGN KEY ("agentId") REFERENCES "public"."chat_hub_agents"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."chat_hub_sessions"
    ADD CONSTRAINT "FK_chat_hub_sessions_agentId" FOREIGN KEY ("agentId") REFERENCES "public"."chat_hub_agents"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."agents_observations"
    ADD CONSTRAINT "FK_d206432be97b7ed88d187479b1b" FOREIGN KEY ("agentId") REFERENCES "public"."agents"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."instance_ai_observations"
    ADD CONSTRAINT "FK_d54fc84a6c8ac91b5e0db0378a4" FOREIGN KEY ("observationScopeId") REFERENCES "public"."instance_ai_threads"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."dynamic_credential_entry"
    ADD CONSTRAINT "FK_d61a12235d268a49af6a3c09c13" FOREIGN KEY ("resolver_id") REFERENCES "public"."dynamic_credential_resolver"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."evaluation_collection"
    ADD CONSTRAINT "FK_d634a0c93fd7de68a87eab951b2" FOREIGN KEY ("evaluationConfigId") REFERENCES "public"."evaluation_config"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."test_run"
    ADD CONSTRAINT "FK_d6870d3b6e4c185d33926f423c8" FOREIGN KEY ("workflowId") REFERENCES "public"."workflow_entity"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."shared_workflow"
    ADD CONSTRAINT "FK_daa206a04983d47d0a9c34649ce" FOREIGN KEY ("workflowId") REFERENCES "public"."workflow_entity"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."instance_ai_observations"
    ADD CONSTRAINT "FK_daef2195a4a846eb70eed15e039" FOREIGN KEY ("parentId") REFERENCES "public"."instance_ai_observations"("id");



ALTER TABLE ONLY "public"."folder_tag"
    ADD CONSTRAINT "FK_dc88164176283de80af47621746" FOREIGN KEY ("tagId") REFERENCES "public"."tag_entity"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."role_mapping_rule_project"
    ADD CONSTRAINT "FK_dd7ce4dfa09e95b36a626bd9de3" FOREIGN KEY ("roleMappingRuleId") REFERENCES "public"."role_mapping_rule"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."workflow_published_version"
    ADD CONSTRAINT "FK_df3428a541b802d6a63ac56e330" FOREIGN KEY ("publishedVersionId") REFERENCES "public"."workflow_history"("versionId") ON DELETE RESTRICT;



ALTER TABLE ONLY "public"."instance_ai_pending_confirmations"
    ADD CONSTRAINT "FK_df5fd25c8bbfd2b042602600d8e" FOREIGN KEY ("userId") REFERENCES "public"."user"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."user_api_keys"
    ADD CONSTRAINT "FK_e131705cbbc8fb589889b02d457" FOREIGN KEY ("userId") REFERENCES "public"."user"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."chat_hub_messages"
    ADD CONSTRAINT "FK_e22538eb50a71a17954cd7e076c" FOREIGN KEY ("sessionId") REFERENCES "public"."chat_hub_sessions"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."test_case_execution"
    ADD CONSTRAINT "FK_e48965fac35d0f5b9e7f51d8c44" FOREIGN KEY ("executionId") REFERENCES "public"."execution_entity"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."chat_hub_messages"
    ADD CONSTRAINT "FK_e5d1fa722c5a8d38ac204746662" FOREIGN KEY ("previousMessageId") REFERENCES "public"."chat_hub_messages"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."chat_hub_session_tools"
    ADD CONSTRAINT "FK_e649bf1295f4ed8d4299ed290f9" FOREIGN KEY ("sessionId") REFERENCES "public"."chat_hub_sessions"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."agent_chat_subscriptions"
    ADD CONSTRAINT "FK_e79153bd179c011e779d5016796" FOREIGN KEY ("agentId") REFERENCES "public"."agents"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."chat_hub_sessions"
    ADD CONSTRAINT "FK_e9ecf8ede7d989fcd18790fe36a" FOREIGN KEY ("ownerId") REFERENCES "public"."user"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."user"
    ADD CONSTRAINT "FK_eaea92ee7bfb9c1b6cd01505d56" FOREIGN KEY ("roleSlug") REFERENCES "public"."role"("slug");



ALTER TABLE ONLY "public"."workflow_publication_trigger_status"
    ADD CONSTRAINT "FK_ef1994db9d0ac1b6a5c89b5f729" FOREIGN KEY ("versionId") REFERENCES "public"."workflow_history"("versionId") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."agent_execution_threads"
    ADD CONSTRAINT "FK_f00b52d74fe11838e1fe086deea" FOREIGN KEY ("taskVersionId") REFERENCES "public"."agent_history"("versionId") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."evaluation_collection"
    ADD CONSTRAINT "FK_f4561f38b5a22a4f090d5cd3eae" FOREIGN KEY ("createdById") REFERENCES "public"."user"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."agent_task_definition"
    ADD CONSTRAINT "FK_f45d0535a2ed59b6c2dd6da98a0" FOREIGN KEY ("agentId") REFERENCES "public"."agents"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."evaluation_config"
    ADD CONSTRAINT "FK_fd7542bb123074760285dc1bbf3" FOREIGN KEY ("workflowId") REFERENCES "public"."workflow_entity"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."instance_ai_threads"
    ADD CONSTRAINT "FK_instance_ai_threads_projectId" FOREIGN KEY ("projectId") REFERENCES "public"."project"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."role_scope"
    ADD CONSTRAINT "FK_role" FOREIGN KEY ("roleSlug") REFERENCES "public"."role"("slug") ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY "public"."scheduled_job"
    ADD CONSTRAINT "FK_scheduled_job_workflowId" FOREIGN KEY ("workflowId") REFERENCES "public"."workflow_published_version"("workflowId") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."scheduled_task"
    ADD CONSTRAINT "FK_scheduled_task_jobId" FOREIGN KEY ("jobId") REFERENCES "public"."scheduled_job"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."role_scope"
    ADD CONSTRAINT "FK_scope" FOREIGN KEY ("scopeSlug") REFERENCES "public"."scope"("slug") ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY "public"."test_run"
    ADD CONSTRAINT "FK_test_run_collection_id" FOREIGN KEY ("collectionId") REFERENCES "public"."evaluation_collection"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."test_run"
    ADD CONSTRAINT "FK_test_run_evaluation_config_id" FOREIGN KEY ("evaluationConfigId") REFERENCES "public"."evaluation_config"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."auth_identity"
    ADD CONSTRAINT "auth_identity_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."user"("id");



ALTER TABLE ONLY "public"."credentials_entity"
    ADD CONSTRAINT "credentials_entity_resolverId_foreign" FOREIGN KEY ("resolverId") REFERENCES "public"."dynamic_credential_resolver"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."execution_data"
    ADD CONSTRAINT "execution_data_fk" FOREIGN KEY ("executionId") REFERENCES "public"."execution_entity"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."execution_entity"
    ADD CONSTRAINT "fk_execution_entity_workflow_id" FOREIGN KEY ("workflowId") REFERENCES "public"."workflow_entity"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."webhook_entity"
    ADD CONSTRAINT "fk_webhook_entity_workflow_id" FOREIGN KEY ("workflowId") REFERENCES "public"."workflow_entity"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."workflow_entity"
    ADD CONSTRAINT "fk_workflow_parent_folder" FOREIGN KEY ("parentFolderId") REFERENCES "public"."folder"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."workflows_tags"
    ADD CONSTRAINT "fk_workflows_tags_tag_id" FOREIGN KEY ("tagId") REFERENCES "public"."tag_entity"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."workflows_tags"
    ADD CONSTRAINT "fk_workflows_tags_workflow_id" FOREIGN KEY ("workflowId") REFERENCES "public"."workflow_entity"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."project"
    ADD CONSTRAINT "projects_creatorId_foreign" FOREIGN KEY ("creatorId") REFERENCES "public"."user"("id") ON DELETE SET NULL;





ALTER PUBLICATION "supabase_realtime" OWNER TO "postgres";


GRANT USAGE ON SCHEMA "public" TO "postgres";
GRANT USAGE ON SCHEMA "public" TO "anon";
GRANT USAGE ON SCHEMA "public" TO "authenticated";
GRANT USAGE ON SCHEMA "public" TO "service_role";






















































































































































GRANT ALL ON FUNCTION "public"."increment_workflow_version"() TO "anon";
GRANT ALL ON FUNCTION "public"."increment_workflow_version"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."increment_workflow_version"() TO "service_role";


















GRANT ALL ON TABLE "public"."agent_chat_subscriptions" TO "anon";
GRANT ALL ON TABLE "public"."agent_chat_subscriptions" TO "authenticated";
GRANT ALL ON TABLE "public"."agent_chat_subscriptions" TO "service_role";



GRANT ALL ON TABLE "public"."agent_checkpoints" TO "anon";
GRANT ALL ON TABLE "public"."agent_checkpoints" TO "authenticated";
GRANT ALL ON TABLE "public"."agent_checkpoints" TO "service_role";



GRANT ALL ON TABLE "public"."agent_execution" TO "anon";
GRANT ALL ON TABLE "public"."agent_execution" TO "authenticated";
GRANT ALL ON TABLE "public"."agent_execution" TO "service_role";



GRANT ALL ON TABLE "public"."agent_execution_threads" TO "anon";
GRANT ALL ON TABLE "public"."agent_execution_threads" TO "authenticated";
GRANT ALL ON TABLE "public"."agent_execution_threads" TO "service_role";



GRANT ALL ON TABLE "public"."agent_files" TO "anon";
GRANT ALL ON TABLE "public"."agent_files" TO "authenticated";
GRANT ALL ON TABLE "public"."agent_files" TO "service_role";



GRANT ALL ON TABLE "public"."agent_history" TO "anon";
GRANT ALL ON TABLE "public"."agent_history" TO "authenticated";
GRANT ALL ON TABLE "public"."agent_history" TO "service_role";



GRANT ALL ON TABLE "public"."agent_task_definition" TO "anon";
GRANT ALL ON TABLE "public"."agent_task_definition" TO "authenticated";
GRANT ALL ON TABLE "public"."agent_task_definition" TO "service_role";



GRANT ALL ON TABLE "public"."agent_task_run_lock" TO "anon";
GRANT ALL ON TABLE "public"."agent_task_run_lock" TO "authenticated";
GRANT ALL ON TABLE "public"."agent_task_run_lock" TO "service_role";



GRANT ALL ON TABLE "public"."agent_task_snapshot" TO "anon";
GRANT ALL ON TABLE "public"."agent_task_snapshot" TO "authenticated";
GRANT ALL ON TABLE "public"."agent_task_snapshot" TO "service_role";



GRANT ALL ON TABLE "public"."agents" TO "anon";
GRANT ALL ON TABLE "public"."agents" TO "authenticated";
GRANT ALL ON TABLE "public"."agents" TO "service_role";



GRANT ALL ON TABLE "public"."agents_memory_entries" TO "anon";
GRANT ALL ON TABLE "public"."agents_memory_entries" TO "authenticated";
GRANT ALL ON TABLE "public"."agents_memory_entries" TO "service_role";



GRANT ALL ON TABLE "public"."agents_memory_entry_cursors" TO "anon";
GRANT ALL ON TABLE "public"."agents_memory_entry_cursors" TO "authenticated";
GRANT ALL ON TABLE "public"."agents_memory_entry_cursors" TO "service_role";



GRANT ALL ON TABLE "public"."agents_memory_entry_locks" TO "anon";
GRANT ALL ON TABLE "public"."agents_memory_entry_locks" TO "authenticated";
GRANT ALL ON TABLE "public"."agents_memory_entry_locks" TO "service_role";



GRANT ALL ON TABLE "public"."agents_memory_entry_sources" TO "anon";
GRANT ALL ON TABLE "public"."agents_memory_entry_sources" TO "authenticated";
GRANT ALL ON TABLE "public"."agents_memory_entry_sources" TO "service_role";



GRANT ALL ON TABLE "public"."agents_messages" TO "anon";
GRANT ALL ON TABLE "public"."agents_messages" TO "authenticated";
GRANT ALL ON TABLE "public"."agents_messages" TO "service_role";



GRANT ALL ON TABLE "public"."agents_observation_cursors" TO "anon";
GRANT ALL ON TABLE "public"."agents_observation_cursors" TO "authenticated";
GRANT ALL ON TABLE "public"."agents_observation_cursors" TO "service_role";



GRANT ALL ON TABLE "public"."agents_observation_locks" TO "anon";
GRANT ALL ON TABLE "public"."agents_observation_locks" TO "authenticated";
GRANT ALL ON TABLE "public"."agents_observation_locks" TO "service_role";



GRANT ALL ON TABLE "public"."agents_observations" TO "anon";
GRANT ALL ON TABLE "public"."agents_observations" TO "authenticated";
GRANT ALL ON TABLE "public"."agents_observations" TO "service_role";



GRANT ALL ON TABLE "public"."agents_resources" TO "anon";
GRANT ALL ON TABLE "public"."agents_resources" TO "authenticated";
GRANT ALL ON TABLE "public"."agents_resources" TO "service_role";



GRANT ALL ON TABLE "public"."agents_threads" TO "anon";
GRANT ALL ON TABLE "public"."agents_threads" TO "authenticated";
GRANT ALL ON TABLE "public"."agents_threads" TO "service_role";



GRANT ALL ON TABLE "public"."ai_builder_temporary_workflow" TO "anon";
GRANT ALL ON TABLE "public"."ai_builder_temporary_workflow" TO "authenticated";
GRANT ALL ON TABLE "public"."ai_builder_temporary_workflow" TO "service_role";



GRANT ALL ON TABLE "public"."annotation_tag_entity" TO "anon";
GRANT ALL ON TABLE "public"."annotation_tag_entity" TO "authenticated";
GRANT ALL ON TABLE "public"."annotation_tag_entity" TO "service_role";



GRANT ALL ON TABLE "public"."auth_identity" TO "anon";
GRANT ALL ON TABLE "public"."auth_identity" TO "authenticated";
GRANT ALL ON TABLE "public"."auth_identity" TO "service_role";



GRANT ALL ON TABLE "public"."auth_provider_sync_history" TO "anon";
GRANT ALL ON TABLE "public"."auth_provider_sync_history" TO "authenticated";
GRANT ALL ON TABLE "public"."auth_provider_sync_history" TO "service_role";



GRANT ALL ON SEQUENCE "public"."auth_provider_sync_history_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."auth_provider_sync_history_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."auth_provider_sync_history_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."binary_data" TO "anon";
GRANT ALL ON TABLE "public"."binary_data" TO "authenticated";
GRANT ALL ON TABLE "public"."binary_data" TO "service_role";



GRANT ALL ON TABLE "public"."chat_hub_agent_tools" TO "anon";
GRANT ALL ON TABLE "public"."chat_hub_agent_tools" TO "authenticated";
GRANT ALL ON TABLE "public"."chat_hub_agent_tools" TO "service_role";



GRANT ALL ON TABLE "public"."chat_hub_agents" TO "anon";
GRANT ALL ON TABLE "public"."chat_hub_agents" TO "authenticated";
GRANT ALL ON TABLE "public"."chat_hub_agents" TO "service_role";



GRANT ALL ON TABLE "public"."chat_hub_messages" TO "anon";
GRANT ALL ON TABLE "public"."chat_hub_messages" TO "authenticated";
GRANT ALL ON TABLE "public"."chat_hub_messages" TO "service_role";



GRANT ALL ON TABLE "public"."chat_hub_session_tools" TO "anon";
GRANT ALL ON TABLE "public"."chat_hub_session_tools" TO "authenticated";
GRANT ALL ON TABLE "public"."chat_hub_session_tools" TO "service_role";



GRANT ALL ON TABLE "public"."chat_hub_sessions" TO "anon";
GRANT ALL ON TABLE "public"."chat_hub_sessions" TO "authenticated";
GRANT ALL ON TABLE "public"."chat_hub_sessions" TO "service_role";



GRANT ALL ON TABLE "public"."chat_hub_tools" TO "anon";
GRANT ALL ON TABLE "public"."chat_hub_tools" TO "authenticated";
GRANT ALL ON TABLE "public"."chat_hub_tools" TO "service_role";



GRANT ALL ON TABLE "public"."credential_dependency" TO "anon";
GRANT ALL ON TABLE "public"."credential_dependency" TO "authenticated";
GRANT ALL ON TABLE "public"."credential_dependency" TO "service_role";



GRANT ALL ON SEQUENCE "public"."credential_dependency_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."credential_dependency_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."credential_dependency_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."credentials_entity" TO "anon";
GRANT ALL ON TABLE "public"."credentials_entity" TO "authenticated";
GRANT ALL ON TABLE "public"."credentials_entity" TO "service_role";



GRANT ALL ON TABLE "public"."data_table" TO "anon";
GRANT ALL ON TABLE "public"."data_table" TO "authenticated";
GRANT ALL ON TABLE "public"."data_table" TO "service_role";



GRANT ALL ON TABLE "public"."data_table_column" TO "anon";
GRANT ALL ON TABLE "public"."data_table_column" TO "authenticated";
GRANT ALL ON TABLE "public"."data_table_column" TO "service_role";



GRANT ALL ON TABLE "public"."deployment_key" TO "anon";
GRANT ALL ON TABLE "public"."deployment_key" TO "authenticated";
GRANT ALL ON TABLE "public"."deployment_key" TO "service_role";



GRANT ALL ON TABLE "public"."dynamic_credential_entry" TO "anon";
GRANT ALL ON TABLE "public"."dynamic_credential_entry" TO "authenticated";
GRANT ALL ON TABLE "public"."dynamic_credential_entry" TO "service_role";



GRANT ALL ON TABLE "public"."dynamic_credential_resolver" TO "anon";
GRANT ALL ON TABLE "public"."dynamic_credential_resolver" TO "authenticated";
GRANT ALL ON TABLE "public"."dynamic_credential_resolver" TO "service_role";



GRANT ALL ON TABLE "public"."dynamic_credential_user_entry" TO "anon";
GRANT ALL ON TABLE "public"."dynamic_credential_user_entry" TO "authenticated";
GRANT ALL ON TABLE "public"."dynamic_credential_user_entry" TO "service_role";



GRANT ALL ON TABLE "public"."evaluation_collection" TO "anon";
GRANT ALL ON TABLE "public"."evaluation_collection" TO "authenticated";
GRANT ALL ON TABLE "public"."evaluation_collection" TO "service_role";



GRANT ALL ON TABLE "public"."evaluation_config" TO "anon";
GRANT ALL ON TABLE "public"."evaluation_config" TO "authenticated";
GRANT ALL ON TABLE "public"."evaluation_config" TO "service_role";



GRANT ALL ON TABLE "public"."event_destinations" TO "anon";
GRANT ALL ON TABLE "public"."event_destinations" TO "authenticated";
GRANT ALL ON TABLE "public"."event_destinations" TO "service_role";



GRANT ALL ON TABLE "public"."execution_annotation_tags" TO "anon";
GRANT ALL ON TABLE "public"."execution_annotation_tags" TO "authenticated";
GRANT ALL ON TABLE "public"."execution_annotation_tags" TO "service_role";



GRANT ALL ON TABLE "public"."execution_annotations" TO "anon";
GRANT ALL ON TABLE "public"."execution_annotations" TO "authenticated";
GRANT ALL ON TABLE "public"."execution_annotations" TO "service_role";



GRANT ALL ON SEQUENCE "public"."execution_annotations_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."execution_annotations_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."execution_annotations_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."execution_data" TO "anon";
GRANT ALL ON TABLE "public"."execution_data" TO "authenticated";
GRANT ALL ON TABLE "public"."execution_data" TO "service_role";



GRANT ALL ON TABLE "public"."execution_entity" TO "anon";
GRANT ALL ON TABLE "public"."execution_entity" TO "authenticated";
GRANT ALL ON TABLE "public"."execution_entity" TO "service_role";



GRANT ALL ON SEQUENCE "public"."execution_entity_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."execution_entity_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."execution_entity_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."execution_metadata" TO "anon";
GRANT ALL ON TABLE "public"."execution_metadata" TO "authenticated";
GRANT ALL ON TABLE "public"."execution_metadata" TO "service_role";



GRANT ALL ON SEQUENCE "public"."execution_metadata_temp_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."execution_metadata_temp_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."execution_metadata_temp_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."folder" TO "anon";
GRANT ALL ON TABLE "public"."folder" TO "authenticated";
GRANT ALL ON TABLE "public"."folder" TO "service_role";



GRANT ALL ON TABLE "public"."folder_tag" TO "anon";
GRANT ALL ON TABLE "public"."folder_tag" TO "authenticated";
GRANT ALL ON TABLE "public"."folder_tag" TO "service_role";



GRANT ALL ON TABLE "public"."insights_by_period" TO "anon";
GRANT ALL ON TABLE "public"."insights_by_period" TO "authenticated";
GRANT ALL ON TABLE "public"."insights_by_period" TO "service_role";



GRANT ALL ON SEQUENCE "public"."insights_by_period_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."insights_by_period_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."insights_by_period_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."insights_metadata" TO "anon";
GRANT ALL ON TABLE "public"."insights_metadata" TO "authenticated";
GRANT ALL ON TABLE "public"."insights_metadata" TO "service_role";



GRANT ALL ON SEQUENCE "public"."insights_metadata_metaId_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."insights_metadata_metaId_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."insights_metadata_metaId_seq" TO "service_role";



GRANT ALL ON TABLE "public"."insights_raw" TO "anon";
GRANT ALL ON TABLE "public"."insights_raw" TO "authenticated";
GRANT ALL ON TABLE "public"."insights_raw" TO "service_role";



GRANT ALL ON SEQUENCE "public"."insights_raw_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."insights_raw_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."insights_raw_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."installed_nodes" TO "anon";
GRANT ALL ON TABLE "public"."installed_nodes" TO "authenticated";
GRANT ALL ON TABLE "public"."installed_nodes" TO "service_role";



GRANT ALL ON TABLE "public"."installed_packages" TO "anon";
GRANT ALL ON TABLE "public"."installed_packages" TO "authenticated";
GRANT ALL ON TABLE "public"."installed_packages" TO "service_role";



GRANT ALL ON TABLE "public"."instance_ai_checkpoints" TO "anon";
GRANT ALL ON TABLE "public"."instance_ai_checkpoints" TO "authenticated";
GRANT ALL ON TABLE "public"."instance_ai_checkpoints" TO "service_role";



GRANT ALL ON TABLE "public"."instance_ai_iteration_logs" TO "anon";
GRANT ALL ON TABLE "public"."instance_ai_iteration_logs" TO "authenticated";
GRANT ALL ON TABLE "public"."instance_ai_iteration_logs" TO "service_role";



GRANT ALL ON TABLE "public"."instance_ai_mcp_registry_connections" TO "anon";
GRANT ALL ON TABLE "public"."instance_ai_mcp_registry_connections" TO "authenticated";
GRANT ALL ON TABLE "public"."instance_ai_mcp_registry_connections" TO "service_role";



GRANT ALL ON TABLE "public"."instance_ai_messages" TO "anon";
GRANT ALL ON TABLE "public"."instance_ai_messages" TO "authenticated";
GRANT ALL ON TABLE "public"."instance_ai_messages" TO "service_role";



GRANT ALL ON TABLE "public"."instance_ai_observation_cursors" TO "anon";
GRANT ALL ON TABLE "public"."instance_ai_observation_cursors" TO "authenticated";
GRANT ALL ON TABLE "public"."instance_ai_observation_cursors" TO "service_role";



GRANT ALL ON TABLE "public"."instance_ai_observation_locks" TO "anon";
GRANT ALL ON TABLE "public"."instance_ai_observation_locks" TO "authenticated";
GRANT ALL ON TABLE "public"."instance_ai_observation_locks" TO "service_role";



GRANT ALL ON TABLE "public"."instance_ai_observational_memory" TO "anon";
GRANT ALL ON TABLE "public"."instance_ai_observational_memory" TO "authenticated";
GRANT ALL ON TABLE "public"."instance_ai_observational_memory" TO "service_role";



GRANT ALL ON TABLE "public"."instance_ai_observations" TO "anon";
GRANT ALL ON TABLE "public"."instance_ai_observations" TO "authenticated";
GRANT ALL ON TABLE "public"."instance_ai_observations" TO "service_role";



GRANT ALL ON TABLE "public"."instance_ai_pending_confirmations" TO "anon";
GRANT ALL ON TABLE "public"."instance_ai_pending_confirmations" TO "authenticated";
GRANT ALL ON TABLE "public"."instance_ai_pending_confirmations" TO "service_role";



GRANT ALL ON TABLE "public"."instance_ai_resources" TO "anon";
GRANT ALL ON TABLE "public"."instance_ai_resources" TO "authenticated";
GRANT ALL ON TABLE "public"."instance_ai_resources" TO "service_role";



GRANT ALL ON TABLE "public"."instance_ai_run_snapshots" TO "anon";
GRANT ALL ON TABLE "public"."instance_ai_run_snapshots" TO "authenticated";
GRANT ALL ON TABLE "public"."instance_ai_run_snapshots" TO "service_role";



GRANT ALL ON TABLE "public"."instance_ai_thread_grants" TO "anon";
GRANT ALL ON TABLE "public"."instance_ai_thread_grants" TO "authenticated";
GRANT ALL ON TABLE "public"."instance_ai_thread_grants" TO "service_role";



GRANT ALL ON TABLE "public"."instance_ai_threads" TO "anon";
GRANT ALL ON TABLE "public"."instance_ai_threads" TO "authenticated";
GRANT ALL ON TABLE "public"."instance_ai_threads" TO "service_role";



GRANT ALL ON TABLE "public"."instance_ai_workflow_snapshots" TO "anon";
GRANT ALL ON TABLE "public"."instance_ai_workflow_snapshots" TO "authenticated";
GRANT ALL ON TABLE "public"."instance_ai_workflow_snapshots" TO "service_role";



GRANT ALL ON TABLE "public"."instance_version_history" TO "anon";
GRANT ALL ON TABLE "public"."instance_version_history" TO "authenticated";
GRANT ALL ON TABLE "public"."instance_version_history" TO "service_role";



GRANT ALL ON SEQUENCE "public"."instance_version_history_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."instance_version_history_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."instance_version_history_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."invalid_auth_token" TO "anon";
GRANT ALL ON TABLE "public"."invalid_auth_token" TO "authenticated";
GRANT ALL ON TABLE "public"."invalid_auth_token" TO "service_role";



GRANT ALL ON TABLE "public"."mcp_registry_server" TO "anon";
GRANT ALL ON TABLE "public"."mcp_registry_server" TO "authenticated";
GRANT ALL ON TABLE "public"."mcp_registry_server" TO "service_role";



GRANT ALL ON TABLE "public"."migrations" TO "anon";
GRANT ALL ON TABLE "public"."migrations" TO "authenticated";
GRANT ALL ON TABLE "public"."migrations" TO "service_role";



GRANT ALL ON SEQUENCE "public"."migrations_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."migrations_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."migrations_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."oauth_access_tokens" TO "anon";
GRANT ALL ON TABLE "public"."oauth_access_tokens" TO "authenticated";
GRANT ALL ON TABLE "public"."oauth_access_tokens" TO "service_role";



GRANT ALL ON TABLE "public"."oauth_authorization_codes" TO "anon";
GRANT ALL ON TABLE "public"."oauth_authorization_codes" TO "authenticated";
GRANT ALL ON TABLE "public"."oauth_authorization_codes" TO "service_role";



GRANT ALL ON TABLE "public"."oauth_clients" TO "anon";
GRANT ALL ON TABLE "public"."oauth_clients" TO "authenticated";
GRANT ALL ON TABLE "public"."oauth_clients" TO "service_role";



GRANT ALL ON TABLE "public"."oauth_refresh_tokens" TO "anon";
GRANT ALL ON TABLE "public"."oauth_refresh_tokens" TO "authenticated";
GRANT ALL ON TABLE "public"."oauth_refresh_tokens" TO "service_role";



GRANT ALL ON TABLE "public"."oauth_user_consents" TO "anon";
GRANT ALL ON TABLE "public"."oauth_user_consents" TO "authenticated";
GRANT ALL ON TABLE "public"."oauth_user_consents" TO "service_role";



GRANT ALL ON SEQUENCE "public"."oauth_user_consents_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."oauth_user_consents_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."oauth_user_consents_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."processed_data" TO "anon";
GRANT ALL ON TABLE "public"."processed_data" TO "authenticated";
GRANT ALL ON TABLE "public"."processed_data" TO "service_role";



GRANT ALL ON TABLE "public"."project" TO "anon";
GRANT ALL ON TABLE "public"."project" TO "authenticated";
GRANT ALL ON TABLE "public"."project" TO "service_role";



GRANT ALL ON TABLE "public"."project_relation" TO "anon";
GRANT ALL ON TABLE "public"."project_relation" TO "authenticated";
GRANT ALL ON TABLE "public"."project_relation" TO "service_role";



GRANT ALL ON TABLE "public"."project_secrets_provider_access" TO "anon";
GRANT ALL ON TABLE "public"."project_secrets_provider_access" TO "authenticated";
GRANT ALL ON TABLE "public"."project_secrets_provider_access" TO "service_role";



GRANT ALL ON TABLE "public"."role" TO "anon";
GRANT ALL ON TABLE "public"."role" TO "authenticated";
GRANT ALL ON TABLE "public"."role" TO "service_role";



GRANT ALL ON TABLE "public"."role_mapping_rule" TO "anon";
GRANT ALL ON TABLE "public"."role_mapping_rule" TO "authenticated";
GRANT ALL ON TABLE "public"."role_mapping_rule" TO "service_role";



GRANT ALL ON TABLE "public"."role_mapping_rule_project" TO "anon";
GRANT ALL ON TABLE "public"."role_mapping_rule_project" TO "authenticated";
GRANT ALL ON TABLE "public"."role_mapping_rule_project" TO "service_role";



GRANT ALL ON TABLE "public"."role_scope" TO "anon";
GRANT ALL ON TABLE "public"."role_scope" TO "authenticated";
GRANT ALL ON TABLE "public"."role_scope" TO "service_role";



GRANT ALL ON TABLE "public"."scheduled_job" TO "anon";
GRANT ALL ON TABLE "public"."scheduled_job" TO "authenticated";
GRANT ALL ON TABLE "public"."scheduled_job" TO "service_role";



GRANT ALL ON SEQUENCE "public"."scheduled_job_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."scheduled_job_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."scheduled_job_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."scheduled_task" TO "anon";
GRANT ALL ON TABLE "public"."scheduled_task" TO "authenticated";
GRANT ALL ON TABLE "public"."scheduled_task" TO "service_role";



GRANT ALL ON SEQUENCE "public"."scheduled_task_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."scheduled_task_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."scheduled_task_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."scope" TO "anon";
GRANT ALL ON TABLE "public"."scope" TO "authenticated";
GRANT ALL ON TABLE "public"."scope" TO "service_role";



GRANT ALL ON TABLE "public"."secrets_provider_connection" TO "anon";
GRANT ALL ON TABLE "public"."secrets_provider_connection" TO "authenticated";
GRANT ALL ON TABLE "public"."secrets_provider_connection" TO "service_role";



GRANT ALL ON SEQUENCE "public"."secrets_provider_connection_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."secrets_provider_connection_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."secrets_provider_connection_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."settings" TO "anon";
GRANT ALL ON TABLE "public"."settings" TO "authenticated";
GRANT ALL ON TABLE "public"."settings" TO "service_role";



GRANT ALL ON TABLE "public"."shared_credentials" TO "anon";
GRANT ALL ON TABLE "public"."shared_credentials" TO "authenticated";
GRANT ALL ON TABLE "public"."shared_credentials" TO "service_role";



GRANT ALL ON TABLE "public"."shared_workflow" TO "anon";
GRANT ALL ON TABLE "public"."shared_workflow" TO "authenticated";
GRANT ALL ON TABLE "public"."shared_workflow" TO "service_role";



GRANT ALL ON TABLE "public"."tag_entity" TO "anon";
GRANT ALL ON TABLE "public"."tag_entity" TO "authenticated";
GRANT ALL ON TABLE "public"."tag_entity" TO "service_role";



GRANT ALL ON TABLE "public"."test_case_execution" TO "anon";
GRANT ALL ON TABLE "public"."test_case_execution" TO "authenticated";
GRANT ALL ON TABLE "public"."test_case_execution" TO "service_role";



GRANT ALL ON TABLE "public"."test_run" TO "anon";
GRANT ALL ON TABLE "public"."test_run" TO "authenticated";
GRANT ALL ON TABLE "public"."test_run" TO "service_role";



GRANT ALL ON TABLE "public"."token_exchange_jti" TO "anon";
GRANT ALL ON TABLE "public"."token_exchange_jti" TO "authenticated";
GRANT ALL ON TABLE "public"."token_exchange_jti" TO "service_role";



GRANT ALL ON TABLE "public"."trusted_key" TO "anon";
GRANT ALL ON TABLE "public"."trusted_key" TO "authenticated";
GRANT ALL ON TABLE "public"."trusted_key" TO "service_role";



GRANT ALL ON TABLE "public"."trusted_key_source" TO "anon";
GRANT ALL ON TABLE "public"."trusted_key_source" TO "authenticated";
GRANT ALL ON TABLE "public"."trusted_key_source" TO "service_role";



GRANT ALL ON TABLE "public"."user" TO "anon";
GRANT ALL ON TABLE "public"."user" TO "authenticated";
GRANT ALL ON TABLE "public"."user" TO "service_role";



GRANT ALL ON TABLE "public"."user_api_keys" TO "anon";
GRANT ALL ON TABLE "public"."user_api_keys" TO "authenticated";
GRANT ALL ON TABLE "public"."user_api_keys" TO "service_role";



GRANT ALL ON TABLE "public"."user_favorites" TO "anon";
GRANT ALL ON TABLE "public"."user_favorites" TO "authenticated";
GRANT ALL ON TABLE "public"."user_favorites" TO "service_role";



GRANT ALL ON SEQUENCE "public"."user_favorites_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."user_favorites_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."user_favorites_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."variables" TO "anon";
GRANT ALL ON TABLE "public"."variables" TO "authenticated";
GRANT ALL ON TABLE "public"."variables" TO "service_role";



GRANT ALL ON TABLE "public"."webhook_entity" TO "anon";
GRANT ALL ON TABLE "public"."webhook_entity" TO "authenticated";
GRANT ALL ON TABLE "public"."webhook_entity" TO "service_role";



GRANT ALL ON TABLE "public"."workflow_builder_session" TO "anon";
GRANT ALL ON TABLE "public"."workflow_builder_session" TO "authenticated";
GRANT ALL ON TABLE "public"."workflow_builder_session" TO "service_role";



GRANT ALL ON TABLE "public"."workflow_dependency" TO "anon";
GRANT ALL ON TABLE "public"."workflow_dependency" TO "authenticated";
GRANT ALL ON TABLE "public"."workflow_dependency" TO "service_role";



GRANT ALL ON SEQUENCE "public"."workflow_dependency_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."workflow_dependency_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."workflow_dependency_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."workflow_entity" TO "anon";
GRANT ALL ON TABLE "public"."workflow_entity" TO "authenticated";
GRANT ALL ON TABLE "public"."workflow_entity" TO "service_role";



GRANT ALL ON TABLE "public"."workflow_history" TO "anon";
GRANT ALL ON TABLE "public"."workflow_history" TO "authenticated";
GRANT ALL ON TABLE "public"."workflow_history" TO "service_role";



GRANT ALL ON TABLE "public"."workflow_publication_outbox" TO "anon";
GRANT ALL ON TABLE "public"."workflow_publication_outbox" TO "authenticated";
GRANT ALL ON TABLE "public"."workflow_publication_outbox" TO "service_role";



GRANT ALL ON SEQUENCE "public"."workflow_publication_outbox_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."workflow_publication_outbox_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."workflow_publication_outbox_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."workflow_publication_trigger_status" TO "anon";
GRANT ALL ON TABLE "public"."workflow_publication_trigger_status" TO "authenticated";
GRANT ALL ON TABLE "public"."workflow_publication_trigger_status" TO "service_role";



GRANT ALL ON TABLE "public"."workflow_publish_history" TO "anon";
GRANT ALL ON TABLE "public"."workflow_publish_history" TO "authenticated";
GRANT ALL ON TABLE "public"."workflow_publish_history" TO "service_role";



GRANT ALL ON SEQUENCE "public"."workflow_publish_history_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."workflow_publish_history_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."workflow_publish_history_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."workflow_published_version" TO "anon";
GRANT ALL ON TABLE "public"."workflow_published_version" TO "authenticated";
GRANT ALL ON TABLE "public"."workflow_published_version" TO "service_role";



GRANT ALL ON TABLE "public"."workflow_statistics" TO "anon";
GRANT ALL ON TABLE "public"."workflow_statistics" TO "authenticated";
GRANT ALL ON TABLE "public"."workflow_statistics" TO "service_role";



GRANT ALL ON TABLE "public"."workflow_statistics_delta" TO "anon";
GRANT ALL ON TABLE "public"."workflow_statistics_delta" TO "authenticated";
GRANT ALL ON TABLE "public"."workflow_statistics_delta" TO "service_role";



GRANT ALL ON SEQUENCE "public"."workflow_statistics_delta_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."workflow_statistics_delta_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."workflow_statistics_delta_id_seq" TO "service_role";



GRANT ALL ON SEQUENCE "public"."workflow_statistics_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."workflow_statistics_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."workflow_statistics_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."workflows_tags" TO "anon";
GRANT ALL ON TABLE "public"."workflows_tags" TO "authenticated";
GRANT ALL ON TABLE "public"."workflows_tags" TO "service_role";









ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "service_role";






ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "service_role";






ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "service_role";































