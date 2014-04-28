namespace :slug do

  desc 'Create Slug'
  task :create do
    on primary fetch(:slug_role) do
      slug_dir = "#{fetch(:tmp_dir)}/#{fetch(:application)}"
      slug_file = "#{slug_dir}/#{fetch(:slug_name)}-slug.tar.gz"
      info "Slug: Creating #{slug_file}"
      execute :mkdir, '-p', slug_dir
      execute "tar czf #{slug_file} -C #{deploy_path} ."
      info "Slug: Successfully created #{slug_file}"
    end
  end

  # pluggable storage backends are in storage.rake
  desc 'Upload Slug'
  task :upload do
    invoke "slug:upload:#{fetch(:slug_storage_backend)}"
  end

  task :clean do
    on primary fetch(:slug_role) do
      slug_file = "#{fetch(:tmp_dir)}/#{fetch(:application)}/#{fetch(:slug_name)}-slug.tar.gz"
      execute :rm, slug_file
      info "Slug: Cleaned #{slug_file}"
    end
  end

end

desc 'Create & upload a new slug'
task :slug => ['slug:create', 'slug:upload', 'slug:clean']

namespace :load do
  task :defaults do

    set :slug_name, -> { fetch(:application) }
    set :slug_role, :web

  end
end
