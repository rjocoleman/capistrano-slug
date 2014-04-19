namespace :slug do
  namespace :upload do

    task :s3 do
      on primary fetch(:slug_role) do
        slug_file = "#{fetch(:slug_name)}-slug.tar.gz"
        slug = "#{fetch(:tmp_dir)}/#{fetch(:application)}/#{slug_file}"
        execute :aws, "s3 cp #{slug} s3://#{fetch(:slug_s3_bucket)}/#{slug_file} --acl private --sse"
        info "Slug: Uploaded #{slug_file}"
      end
    end

  end
end

namespace :load do
  task :defaults do

    set :slug_storage_backend, 's3'
    set :slug_s3_bucket, nil

  end
end
