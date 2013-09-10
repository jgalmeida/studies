class JobDependencies

  def self.resolve_dependencies(jobs)
    accum  = []

    jobs_list = string_to_hash(jobs)

    jobs_list.each_key do |key|
      resolve_dependency(jobs_list, key, accum, [])
    end

    accum
  end

  def self.resolve_dependency(jobs_list, key, accum, checked)
    checked << key
    unless jobs_list[key].nil?
      raise "Jobs can't depend on themselves: #{key} depends on #{jobs_list[key]}" if key == jobs_list[key]
      raise "Jobs can't have circular dependencies" if checked.include? jobs_list[key]

      resolve_dependency(jobs_list, jobs_list[key], accum, checked) unless accum.include? key
    end
    accum << key unless accum.include? key
  end

  def self.string_to_hash(jobs)
    hash = {}
    jobs.delete(' ').split(",").each do |el|
      job = el.split("=>")
      hash[job[0]] = job[1]
    end
    hash
  end

end